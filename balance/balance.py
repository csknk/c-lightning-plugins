#!/usr/bin/env python3
from lightning import Plugin, Millisatoshi
import time

plugin = Plugin()

@plugin.method("balance")
def balance(plugin):
    """
    Docs for balance plugin
    """
    funds = plugin.rpc.listfunds()
    s = {}
    s['onchain'] = sum([f['amount_msat'] for f in funds['outputs']
        if f['status'] == 'confirmed'],
        Millisatoshi(0))

    s['lightning'] = sum([c['our_amount_msat'] for c in funds['channels']],
            Millisatoshi(0))
    return s

plugin.run()

