#!/bin/bash
# Runs after the WordPress entrypoint (which sets up wp-config.php).
# Fixes any MPM conflict right before Apache starts and prints diagnostics.
set -e

echo "=== MPM diagnostics ==="
echo "-- mods-enabled MPM files:"
ls /etc/apache2/mods-enabled/mpm* 2>/dev/null || echo "  (none)"

echo "-- LoadModule MPM lines in apache2.conf:"
grep -i 'LoadModule mpm' /etc/apache2/apache2.conf 2>/dev/null || echo "  (none)"

echo "-- LoadModule MPM lines in mods-enabled:"
grep -ri 'LoadModule mpm' /etc/apache2/mods-enabled/ 2>/dev/null || echo "  (none)"

echo "=== Applying MPM fix ==="
# Remove all dynamic MPM module files
rm -f /etc/apache2/mods-enabled/mpm_*.load \
      /etc/apache2/mods-enabled/mpm_*.conf

# Remove any inline LoadModule mpm_* lines from apache2.conf
sed -i '/LoadModule mpm_/d' /etc/apache2/apache2.conf

# Re-enable only prefork (required for mod_php)
a2enmod mpm_prefork

echo "=== Config test ==="
apache2ctl configtest 2>&1 || true

echo "=== Starting Apache ==="
exec apache2-foreground
