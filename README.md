# nomad_follower
Log forwarder for aggregating allocation logs from nomad worker agents.

## Running the application 
Run the application on each worker in a nomad cluster.
```
docker pull sas1024/nomad_follower:latest
docker run -v log_folder:/log -e LOG_TAG="logging" "-e LOG_FILE="/log/nomad-forwarder.log" sas1024/nomad_follower:latest
```

nomad_follower:
 - will follow all allocations if it contains service tag ```nomad_follower``` (can be changed with `LOG_TAG` environment variable) on the worker and tail the allocation logs to the aggregate log file. 
 - will stop following completed allocations and will start following new allocations as they become available. 
 - can be deployed with nomad in a system task group along with a log collector. The aggregate log file can then be shared with the log collector by writing the aggregate log file into the shared allocation folder. 
 - formats log entries as json formatted logs. It will convert string formatted logs to json formatted logs by passing the log entry in the ```message``` key. 
 - adds a ```service_name``` key that contains the listed service names for a task.

Using nomad_follower prevents the cluster operator from having to run a log collector in every task group for every task on a worker while still allowing nomad to handle the logs for each allocation. 
