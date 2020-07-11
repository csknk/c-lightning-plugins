C-Lightning Plugins
===================
Work in Progress, experiments.

Setup Notes: Regtest Network
----------------------------

Clone the c-lightning repo:

```bash
git clone git@github.com:ElementsProject/lightning.git
```
Setup Two Test Nodes on Regtest
-------------------------------
Use the script: `contrib/startup_regtest.sh`.

You may or may not need to set the following variables, either on a per session basis or in `~/.bashrc`:

```bash
# .bashrc
#
# Some variables for lightningd development regtest testnet
export PATH_TO_BITCOIN=/media/secure-hdd-2/bitcoin-data
export PATH_TO_LIGHTNING=/path/to/lightning
```
Note that if not explicitly set, the `contrib/startup_regtest.sh` script sets these values to sensible defaults:

`$PATH_TO_LIGHTNING` is set to the current working directory, providing this contains executables `cli/lightning-cli` and `lightningd/lightningd` - i.e. you have built `c-lightning` but not installed it, and you're running `contrib/startup_regtest.sh` from the root of the `c-lightning` directory.

If these conditions aren't met, but you have installed the executables, the executables are defined directly.

__If you have installed the executables, you don't need to explicitly set `$PATH_TO_LIGHTNING`.__

Aliases
-------
Once you source the script, you get access to the following convenient aliases:

* `l1-cli`: `/path/to/lightning-cli --lightning-dir=/tmp/l1-regtest`
* `l2-cli`: `/path/to/lightning-cli --lightning-dir=/tmp/l2-regtest`
* `bt-cli`: `bitcoin-cli -regtest`
* `l1-log`: `less /tmp/l1-regtest/log`
* `l2-log`: `less /tmp/l2-regtest/log`

Start & Manage Test Network
---------------------------
Sourcing the script sets up aliases and creates two temporary lightning node directories: `/tmp/l1-regtest` and `/tmp/l2-regtest`.

* `start_ln`: Start Lightning nodes
* `stop_ln`: Stops the lightning/bitcoin daemons
* `cleanup_ln`: Runs `stop_ln`, removes all aliases, unsets commands

After running `cleanup_ln` you need to re-source the script - but the data directories created under `/tmp` will remain. If you want these to persist for further testing after a system reboot, consider modifying the script to add the regtest lightning directories in a more permanent location.

Load Plugin
-----------
```
network=regtest
log-level=debug
log-file=/tmp/l1-regtest/log
addr=localhost:6060
plugin=/home/david/Projects/lightning/plugins/balance/balance.py
```

Plugin Libraries: Python
------------------------
```bash
pip install pyln-client pyln-testing pylightning
```

References
----------
* [Video by Rusty Russell][1]
* [Plugin API][2]

[1]: https://www.youtube.com/watch?v=fab4P3BIZxk
[2]: https://lightning.readthedocs.io/PLUGINS.html
