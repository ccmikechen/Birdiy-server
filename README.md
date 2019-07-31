# Birdiy Server

## Development

### Start dev server

```bash
mix phx.server
```

### Start dev server with iex console

```bash
iex -S mix.phx server
```

## Deployment

### Ping

```bash
mix edeliver ping [staging|production]
```

### Check status

```bash
mix edeliver status [staging|production]
```

### Build release

```bash
mix edeliver build release [staging|production] --branch=[branch]
```

### Deploy

```bash
mix edeliver deploy release [staging|production]
```

### Migrate

```bash
mix edeliver migrate
```
