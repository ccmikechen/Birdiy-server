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

#### Production

```fish
env RELEASE_STORE=.deliver/releases/production/ BIRDIY_BUILD_HOST=birdiy-build-prd mix edeliver build release --tag=v0.x.x
```

#### Staging

```fish
env RELEASE_STORE=.deliver/releases/staging/ BIRDIY_BUILD_HOST=birdiy-build-stg mix edeliver build release --tag=v0.x.x
```

### Deploy release

#### Production

```fish
env RELEASE_STORE=.deliver/releases/production/ mix edeliver deploy release to production --version=0.x.x
```

#### Staging

```fish
env RELEASE_STORE=.deliver/releases/staging/ mix edeliver deploy release to staging --version=0.x.x
```

### Build upgrade

#### Production

```fish
env RELEASE_STORE=.deliver/releases/production/ BIRDIY_BUILD_HOST=birdiy-build-prd mix edeliver build upgrade --with=0.x.x --to=v0.x.x
```

#### Staging

```fish
env RELEASE_STORE=.deliver/releases/staging/ BIRDIY_BUILD_HOST=birdiy-build-stg mix edeliver build upgrade --with=0.x.x --to=v0.x.x
```

### Deploy upgrade

#### Production

```fish
env RELEASE_STORE=.deliver/releases/production/ mix edeliver deploy upgrade to production --version=0.x.x
```

#### Staging

```fish
env RELEASE_STORE=.deliver/releases/staging/ mix edeliver deploy release to staging --version=0.x.x
```

### After deployment

* Do copy `/home/deploy/apps/birdiy/releases/start_erl.data` to `/home/deploy/apps/birdiy/var/start_erl.data` or just delete the latter one, it would genereate a correct one automatically. [edeliver/edeliver#314](https://github.com/edeliver/edeliver/issues/314)
