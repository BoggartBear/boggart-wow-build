param(
    [string] $v = "test"
)

$images = @(
    "authserver",
    "client-data",
    "worldserver",
    "db-import"
)

foreach ($name in $images) {
    $source = "acore/ac-wotlk-${name}:master"
    $destination = "boggartbear/ac-wotlk-${name}:$v"

    Write-Host "Tagging $source as $destination"
    docker image tag $source $destination
    if ($LASTEXITCODE -ne 0) {
        throw "Failed to tag $source"
    }

    Write-Host "Pushing $destination"
    docker push $destination
    if ($LASTEXITCODE -ne 0) {
        throw "Failed to push $destination"
    }
}