#!/bin/bash
log=/home/david/Learning/bitcoin/lightning/plugins/plugin.log
manifest=/home/david/Learning/bitcoin/lightning/plugins/dumb.json
echo "Start plugin..." >> $log

# Remove while loop to trigger a big crash in lightningd
while read request; do
	echo request: >> $log
	echo $request >> $log

	id=$(echo -n $request | jq '.id')
	method=$(echo -n $request | jq -r '.method')
	echo "method: $method" >> $log

	error=""
	case $method in
		init)
			endpoint_dir=$(echo -n $request | jq -r '.params.configuration."lightning-dir"')
			endpoint=$endpoint_dir/$(echo -n $request | jq -r '.params.configuration."rpc-file"')
			echo $endpoint >> $log
			;;
		getmanifest)
			echo "sending manifest..." >> $log
			result=$(cat $manifest)
			echo $result >> $log
			echo $result
			;;
		hello)
			val=$(echo -n $request | jq -r '.params'[0])
			val="Please reinstall universe, $val and redo from start..."
			result={\"jsonrpc\":\"2.0\",\"method\":\"greeting\",\"id\":$id,\"result\":\"$val\"}
			echo "sending result..." >> $log
			echo $result >> $log
			echo $result
			;;
		p-newaddr)
			# Use the data from init to get the lightning-rpc filename and lightnign dir.
			# Make a working rpc connection with this, send an RPC command, get a result.
			
			#result={\"jsonrpc\":\"2.0\",\"method\":\"newaddr\",\"id\":$id,\"result\":\"$val\"}
			#val=$(echo -n $request | jq -r '.params'[0])
			#echo $val >> $log
			

			;;
			
		*)
			error="Method not recognised"
			;;
	esac
done
