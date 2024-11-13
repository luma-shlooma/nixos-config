This is a small script to "touch" new files with configuration for default data.  
It consists of a shell script, a shell alias for the script, and a shell environment variable pointing to the local config directory.  
The config directory should be at ~/.config/toucher.  
It should contain subdirectories named after extensions.  
Within these subdirectories should be a default.`ext` file and perhaps `fullname`.`ext` for specific files.  

For example...  
```
~/.config/toucher/  
  nix/
    default.nix  # Default template for all nix files
    shell.nix    # Specific template for nix shell files
  sh/
    default.sh   # Default template for shell scripts (shbang maybe)

# Other files are created empty
```

