# Blender Add-on Template

This is a template for creating Blender add-ons. It uses [uv](https://github.com/astral-sh/uv) to manage dependencies and virtual environments.

## Instructions

1. Change names and info in the following files (don't forget the copyright hearders):
  - `pyproject.toml` (including the path in the `[tool.hatch.version]` section)
  - `my_addon/__init__.py`
  - `my_addon/auto_load.py` (copyright header only)
  - `my_addon/panel_mypanel.py`

2. Rename the `my_addon` directory to the name of your add-on. It should match the name in `pyproject.toml`

3. Install [uv](https://github.com/astral-sh/uv) and run `uv sync` to initialize the virtual environment and install the dependencies:

```bash
uv sync
```

4. Activate the virtual environment:

```bash
source .venv/bin/activate
```

5. Open your editor and start developing your add-on. (Preferably, start your editor from inside of the virtualenv shell)
  - For Neovim, the [`blender.nvim`](https://github.com/b0o/blender.nvim) plugin is recommended.
  - For VSCode, the [`blender_vscode`](https://github.com/JacquesLucke/blender_vscode) extension is recommended.

6. Build the add-on by running the following command:

  ```bash
  ./scripts/build.sh
  ```

  This will create a zip file in the `dist` directory.

## License

Blender Add-on Template &copy; 2024 Maddison Hellstrom

GNU General Public License v2.0 or later
