#!/bin/bash

function checkSecuritylevel() {
    local pci_services=("cupid" "dione" "phobos" "scorpio" "titan" "umbriel")
    for pci_service in "${pci_services[@]}"; do
        files=($(grep -HRl "https://$pci_service.pleo.io" k8s/product-production/))
        echo "all files $files"
        for file in "${files[@]}"; do
            find k8s/product-production -type f -name $(basename $file) -exec sed -i '' -e "s#securityLevel: internal#securityLevel: pci-connected#g" {} +
        done
        break
    done
}

function changeUrls() {
    services=("amalthea" "commercial-pricing-calculator" "europa" "kalyke" "pandia" "styx"
    "ananke" "cordelia" "exportdispatcher" "kari" "pandora" "tarvos"
    "another-peimos-victor-test" "cupid" "exportlanetracker" "kerberos" "perdita" "taskmanager"
    "another-peimos" "curiosity" "ganymede" "kustomization" "phobos" "telesto"
    "ariel" "customer-vulnerability-tracker" "gjoll" "larissa" "phoebe" "thalassa"
    "auxo" "deimos" "hades" "limit-spend-tracker" "pluto" "thanatos"
    "backend-service-template" "dione" "hecate" "mab" "prospero" "thebe"
    "beyond" "dionysus" "henosis" "metis" "puck" "themis"
    "bookkeepingrules" "dysnomia" "hermes" "mimas" "review-management" "titan"
    "brokkr" "eirene" "houston" "miranda" "rosalind" "titania"
    "budgets" "elara" "hr-integrations" "mj-product-demo-one" "scorpio" "triton"
    "cadmus" "enceladus" "hydra" "mj-product-demo-two" "secretsmanager-backup" "umbriel"
    "caliban" "endymion" "io" "narvi" "skoll" "uranus"
    "callisto" "epimetheus" "istio-ingressgateway" "nereid" "spend-projection" "urd"
    "calypso" "ersa" "janus" "oberon" "spendpolicies"
    "categorysuggestions" "eunomia" "juliet" "onboarding-playground" "sputnik"
    "charon" "euporie" "kale" "openbanking-gateway" "strawberry-six"
    "cicd-improvements-test-service" "europa-bigquery-consumer" "kallichore" "pan" "strawberry-ten")

    for service in "${services[@]}"; do
        find k8s/product-production -type f -name "*.yaml" -exec sed -i '' -e "s#https://$service.pleo.io#http://$service.$service#g" {} +
    done

    find k8s/product-production -type f -name "*.yaml" -exec sed -i '' -e 's#https://auth.pleo.io#http://kerberos.kerberos#g' {} +
}


if [ -d "k8s" ]; then
    checkSecuritylevel
    changeUrls
fi