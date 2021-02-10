# cardano-stakepool-config
Config for cardano stake pool

## Viewing and filter logs

```
journalctl --unit=cardano-node --follow
```

```
journalctl --unit=cardano-node --since=yesterday
```

```
journalctl --unit=cardano-node --since=today
```

```
journalctl --unit=cardano-node --since='2020-07-29 00:00:00' --until='2020-07-29 12:00:00'
```
