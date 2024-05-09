# [SRE-5197 : Move from ingress to k8s service for internal traffic](https://linear.app/pleo/issue/SRE-5197/move-from-ingress-to-k8s-service-for-internal-traffic)

This folder contains script and configuration used with [`multi-gitter`]() in order to switch to use the internal kubernetes service instead of the `*.pleo.io` address for internal traffic.

We also check for services that needs to change their `securityLevel` settings to `pci-connected`.

## Content of this folder

Scripts for changing URLs:
- [product-dev.bash](./product-dev.bash)
- [product-staging.bash](./product-staging.bash)
- [product-production.bash](./product-production.bash)

Configurations for `multi-gitter`
- [product-dev.yaml](./product-dev.yaml)
- [product-staging.yaml](./product-staging.yaml)
- [product-production.yaml](./product-production.yaml)

## How do we use this?

1. First we get a list of all services running in `product-dev` looking at the list of apps registered in `flux-config`
2. Run this with `multi-gitter` targeting only the service `ananke` using the `product-dev.yaml` config
    - comment out the org
    - comment out the list of repos to only operate on `ananke` for testing purposes
    - run `multi-gitter run product-dev.bash --config=product-dev.yaml`
3. Validate that works by merging the PR generated at step 2
4. Run this against all remaining services in `product-dev`
5. Merge all PRs and observe for a day
6. Proceed with `product-staging` generating PRs for all services
7. Merge PRs for `product-staging` and observe for ~2 days
    - don't merge all PRs at once, we merge slowly and observe
8. Proceed with `product-production` generating PRs for all services
7. Merge PRs for `product-production` and pray 🙏
    - don't merge all PRs at once, we merge slowly and observe
