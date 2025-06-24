# nvim-cfg

Missing features:
* loading only the LSPs that are nedded;
* debug using single installation of debugpy;

---

## Debugging

This Neovim configuration includes robust debugging capabilities powered by `nvim-dap` and `nvim-dap-ui`, with pre-configured adapters for **Python** and **Assembly** languages.

#### Configurations

Dap automatically checks for configurations on .vscode/launch.json
lauch.json template:
```json
{
    "version": "0.2.0",
    "configurations": [
        // --- Python Configuration ---
        {
            "name": "Python: Current File",
            "type": "python",
            "request": "launch",
            "program": "${file}",
            "console": "integratedTerminal",
            "justMyCode": true
        },
        {
            "name": "Python: Debug Specific Script",
            "type": "python",
            "request": "launch",
            "program": "${workspaceFolder}/src/main.py", // Adjust path to your main script
            "console": "integratedTerminal",
            "args": ["arg1", "arg2"], // Example arguments
            "justMyCode": true
        },
        {
            "name": "Python: Module",
            "type": "python",
            "request": "launch",
            "module": "my_package.main", // Replace with your module name
            "console": "integratedTerminal"
        },

        // --- C/C++ Configuration (using the C/C++ Extension) ---
        {
            "name": "C/C++: (gdb) Launch",
            "type": "cppdbg",
            "request": "launch",
            "program": "${workspaceFolder}/build/my_program", // Adjust path to your compiled executable
            "args": [],
            "stopAtEntry": false,
            "cwd": "${workspaceFolder}",
            "environment": [],
            "externalConsole": false,
            "MIMode": "gdb",
            "setupCommands": [
                {
                    "description": "Enable pretty-printing for gdb",
                    "text": "-enable-pretty-printing",
                    "ignoreFailures": true
                }
            ],
            "preLaunchTask": "build_c_cpp" // Optional: Task to build before launching
        },

        // --- Rust Configuration (using the CodeLLDB or Native Debug extension) ---
        // Option 1: Using CodeLLDB (Recommended for Rust)
        {
            "name": "Rust: Debug with CodeLLDB",
            "type": "lldb",
            "request": "launch",
            "program": "${workspaceFolder}/target/debug/your_rust_binary_name", // Adjust path
            "args": [],
            "cwd": "${workspaceFolder}",
            "sourceMap": {
                // If you're running from an environment where your source files are mapped
                // in a different location than your local machine, specify that here.
            },
            "stopOnEntry": false,
            "preLaunchTask": "build_rust_debug" // Optional: Task to build debug version
        },
        // Option 2: Using Native Debug (if CodeLLDB isn't preferred or causing issues)
        // Requires "Native Debug" extension
        // {
        //     "name": "Rust: Debug with Native Debug (GDB/LLDB)",
        //     "type": "gdb", // Or "lldb" depending on your debugger
        //     "request": "launch",
        //     "target": "${workspaceFolder}/target/debug/your_rust_binary_name",
        //     "cwd": "${workspaceFolder}",
        //     "arguments": "",
        //     "valuesFormatting": "parseText"
        // },

        // --- Go Configuration (using the Go Extension) ---
        {
            "name": "Go: Launch File",
            "type": "go",
            "request": "launch",
            "mode": "debug",
            "program": "${file}",
            "env": {},
            "args": []
        },
        {
            "name": "Go: Launch Package",
            "type": "go",
            "request": "launch",
            "mode": "debug",
            "program": "${workspaceFolder}", // Launches the main package in your workspace
            "env": {},
            "args": []
        },

        // --- TypeScript Configuration (Node.js) ---
        // For debugging TypeScript that will be run with Node.js
        {
            "name": "TypeScript: Launch Node.js",
            "type": "node",
            "request": "launch",
            "args": ["${workspaceFolder}/src/main.ts"], // Or your compiled JS file: "${workspaceFolder}/dist/main.js"
            "runtimeArgs": [
                "--nolazy",
                "-r",
                "ts-node/register" // For directly running .ts files without pre-compilation
            ],
            "cwd": "${workspaceFolder}",
            "protocol": "inspector",
            "console": "integratedTerminal",
            "internalConsoleOptions": "neverOpen",
            "skipFiles": [
                "<node_internals>/**"
            ],
            "sourceMaps": true,
            "outFiles": [
                "${workspaceFolder}/dist/**/*.js" // If you compile TS to JS, specify the output directory
            ]
        },
        {
            "name": "TypeScript: Attach to Node.js Process",
            "type": "node",
            "request": "attach",
            "name": "Attach by Process ID",
            "processId": "${command:PickProcess}",
            "skipFiles": [
                "<node_internals>/**"
            ],
            "sourceMaps": true,
            "outFiles": [
                "${workspaceFolder}/dist/**/*.js"
            ]
        },

        // --- Assembly Language Configuration (requires specific extensions and setup) ---
        // Debugging assembly directly in VS Code is highly dependent on the target
        // architecture and the debugger you're using (e.g., GDB, LLDB, specific
        // hardware debuggers). This is a *very* generic example that assumes GDB
        // and a compiled executable. You will likely need to adjust this significantly.
        {
            "name": "Assembly: Debug with GDB",
            "type": "cppdbg", // Using cppdbg as it supports GDB
            "request": "launch",
            "program": "${workspaceFolder}/build/your_assembly_program", // Path to your assembled executable
            "args": [],
            "stopAtEntry": true, // Often useful for assembly to stop at the first instruction
            "cwd": "${workspaceFolder}",
            "environment": [],
            "externalConsole": false,
            "MIMode": "gdb",
            "setupCommands": [
                {
                    "description": "Enable pretty-printing for gdb",
                    "text": "-enable-pretty-printing",
                    "ignoreFailures": true
                },
                {
                    "description": "Set disassembly flavor",
                    "text": "set disassembly-flavor intel", // Or "att" for AT&T syntax
                    "ignoreFailures": true
                }
            ],
            "preLaunchTask": "assemble_link_assembly" // Optional: Task to assemble and link
        }
    ]
}
```

---

### Python Debugging

This configuration supports debugging Python applications using `debugpy`. It automatically detects and uses virtual environments (`venv` or `.venv`) if present in your project's root.

#### Prerequisites

* **`debugpy`**: Ensure `debugpy` is installed in your Python environment.
    ```bash
    pip install debugpy
    ```
* **Virtual Environment (Recommended)**: If using a virtual environment, activate it before launching Neovim to ensure `debugpy` is correctly found.

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

