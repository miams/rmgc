# Create auto-loading config file
mkdir $"($nu.default-config-dir)/vendor/autoload"

# Customize Nushell Configuration
"# Tailored Nushell Configuration \n"                 | save -f $"($nu.default-config-dir)/config.nu"
echo "$env.config.buffer_editor = \"vi\"\n"           | save --append $"($nu.default-config-dir)/config.nu" 
echo "\n"                                             | save --append $"($nu.default-config-dir)/config.nu" 
echo "$env.config.history.file_format = \"sqlite\"\n" | save --append $"($nu.default-config-dir)/config.nu"
echo "$env.config.history.max_size = 5_000_000\n"     | save --append $"($nu.default-config-dir)/config.nu"
echo "$env.config.history.sync_on_enter = true\n"     | save --append $"($nu.default-config-dir)/config.nu"
echo "$env.config.history.isolation = true\n"         | save --append $"($nu.default-config-dir)/config.nu"

# With fresh install we are defaulting to a demo mode. 
# Create startup config file with values for demo 
print "Configuring to use demo mode with fresh install."

echo $"\n $env.rmgc-mode = 'demo' \n $env.rmdb = '($nu.home-path)/Apps/rmgc/data/pres2020.rmtree'" 
   | save -f $"($nu.default-config-dir)/vendor/autoload/rmgc-config.nu"

echo $"\n $env.rmgc_sql = '($nu.home-path)/Apps/rmgc/sql/'" 
   | save --append $"($nu.default-config-dir)/vendor/autoload/rmgc-config.nu"

echo $"\n alias syncdb = cp ($nu.home-path)/Apps/rmgc/data/originaldb/pres2020.rmtree ($nu.home-path)/Apps/rmgc/data/pres2020.rmtree" 
   | save --append $"($nu.default-config-dir)/vendor/autoload/rmgc-config.nu" 

echo $"\n source ($nu.home-path)/Apps/rmgc/src/source-commands.nu" 
   | save --append $"($nu.default-config-dir)/vendor/autoload/rmgc-config.nu" 

print $"(ansi green_bold)Configuration complete.(ansi reset) These are the configuration settings:" 
print "config.nu: "
cat $"($nu.default-config-dir)/config.nu"
print "rmgc-config.nu: "
cat $"($nu.default-config-dir)/vendor/autoload/rmgc-config.nu"
print ""

print "Installing RMGC."
# create file structure
# safe to run repeatedly, it does not error if already exists

mkdir $"($nu.home-path)/Apps/rmgc/data"
mkdir $"($nu.home-path)/Apps/rmgc/sql"
mkdir $"($nu.home-path)/Apps/rmgc/src"

# Load rmgc source code
curl -s -o  $"($nu.home-path)/Apps/rmgc/src/source-commands.nu" "https://raw.githubusercontent.com/miams/rmgc/refs/heads/main/src/source-commands.nu"

# Load a sample RootsMagic database.
print "Installing sample RootsMagic database." 
curl -s -o  $"($nu.home-path)/Apps/rmgc/data/pres2020.rmtree" "https://raw.githubusercontent.com/miams/rmgc/8d3fab75dab83b157e510b352065f152126cf6fa/demo/pres2020.rmtree"

# Create a copy of demo RM database so syncdb works end-to-end
mkdir $"($nu.home-path)/Apps/rmgc/data/originaldb"
cp $"($nu.home-path)/Apps/rmgc/data/pres2020.rmtree" $"($nu.home-path)/Apps/rmgc/data/originaldb/pres2020.rmtree"

print ""
print ""
print $"(ansi green_bold)Installation Complete!(ansi reset)"  
print ""
print $"Next, reload settings by closing this terminal session and starting a new Nushell terminal." 
print $"In the new window, begin having fun with RMGC by typing: (ansi default_bold)rmgc [tab key](ansi reset)."