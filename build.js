const esbuild = require("esbuild");
const ElmPlugin = require("esbuild-plugin-elm");

const watch = process.argv.includes("--watch");
const isProd = process.env.NODE_ENV === "production";

esbuild
  .build({
    entryPoints: ["src/scriptoriumLocal.js"],
    bundle: true,
    minify: isProd,
    watch,
    outfile: "dist/bundle.js",
    loader: {
      ".woff2": "dataurl",
      ".svg": "svg",
    },
    plugins: [
      ElmPlugin({
        debug: true,
        optimize: isProd,
        clearOnWatch: watch,
        verbose: true,
      }),
    ],
  })
  .catch((_e) => process.exit(1));
