# nvim-cfg

Missing features:
* loading only the LSPs that are nedded;
* debug using single installation of debugpy;

---

## Debugging

This Neovim configuration includes robust debugging capabilities powered by `nvim-dap` and `nvim-dap-ui`, with pre-configured adapters for **Python** and **Assembly** languages.

---

### Python Debugging

This configuration supports debugging Python applications using `debugpy`. It automatically detects and uses virtual environments (`venv` or `.venv`) if present in your project's root.

#### Prerequisites

* **`debugpy`**: Ensure `debugpy` is installed in your Python environment.
    ```bash
    pip install debugpy
    ```
* **Virtual Environment (Recommended)**: If using a virtual environment, activate it before launching Neovim to ensure `debugpy` is correctly found.

#### Configurations

Dap automatically checks for configurations on .vscode/launch.json

---

### Assembly Debugging

Debugging assembly code is supported via `codelldb`, which provides an LLDB-based debugging experience. This setup is particularly useful for low-level analysis.

#### Prerequisites

* **`codelldb`**: Install `codelldb` via Mason (recommended) or manually. If installed via Mason, your configuration will automatically find it.

#### Configurations

The primary configuration for assembly debugging is:

* **Launch Assembly Program (`Launch Assembly Program`)**: This configuration is designed for launching and debugging compiled assembly executables. When you initiate debugging with this configuration, Neovim will prompt you to specify the path to your executable.

    **Key Features for Assembly Debugging:**
    * **`stopOnEntry = true`**: The debugger will stop immediately at the program's entry point, allowing you to inspect the initial state.
    * **`disableASLR = true`**: Address Space Layout Randomization is disabled, making memory addresses consistent across debugging sessions, which is crucial for analyzing specific memory locations in assembly.
    * **`showDisassembly = "always"`**: The disassembly view will always be shown, ensuring you see the low-level instructions instead of source code, even if source code is technically available.

To begin debugging an assembly program, run `:lua require('dap').continue()`, select "Launch Assembly Program", and provide the path to your compiled executable.

