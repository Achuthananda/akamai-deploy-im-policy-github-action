# akamai-deploy-im-policy-github-action
GitHub Action which deploys Image Manger Policy files to Akamai's Image Manager.

<img src="https://developer.akamai.com/assets/img/developer-experience-logo.png" alt="akamai developer experience logo" width="200"/>

**Important Note**: please copy the YAML syntax from **this README file** (see "workflow.yml Example" section below) into your action YAML and fill in the right values for "setPolicy" parameter to match your Image Manager Policy, policyList which has the list of all policies and network to determine staging/production/both.

# Upload Image Manager Policy.   

This action uses [Akamai Image Manager CLI](https://github.com/akamai/cli-image-manager) to upload the Image Manager Policy.

## Usage

Setup your repository with the following files:
```
<repository name>
            - [policyname.json]
```

For example if your Image manager policy is "apitest" you should have a file called "apitest.json" containing the image quality and transformation settings. See [Image Manager](https://developer.akamai.com/api/web_performance/image_manager/v2.html#policy) for reference.

An Image Manager Policy json file would look something like this:
```
{
  "breakpoints": {
    "widths": [
      320,
      640,
      5000
    ]
  },
  "id": "apitest",
  "output": {},
  "transformations": [
    {
      "transformation": "BackgroundColor",
      "color": "#5a2626"
    }
  ],
  "video": false
}
```

## Secrets

All sensitive variables should be [set as encrypted secrets](https://help.github.com/en/articles/virtual-environments-for-github-actions#creating-and-using-secrets-encrypted-variables) in the action's configuration.

You need to declare an `EDGERC` secret in your repository containing the following structure :
```
[im]
client_secret = your_client_secret
host = your_host
access_token = your_access_token
client_token = your_client_token
```

You can retrieve these from [Akamai Control Center](https://control.akamai.com/) >> Identity Management >> API User.

## Inputs

### `setPolicy` (**Required**)
Image Manager Set Policy: The name of your Image Manager Policy in the config ('exampleIM' in our example)

### `policyList` (**Required**)
List of Policies: Each main policy can have many policies under it. The name of all policies which needs to be updated or created.

### `network` (**Required**)
Network of Deployment: The network to which the policy should be deployed.[staging/production/both]

## workflow.yml Example

Place in a `.yml` file such as this one in your `.github/workflows` folder. [Refer to the documentation on workflow YAML syntax here.](https://help.github.com/en/articles/workflow-syntax-for-github-actions)

```yaml
steps:
    - uses: actions/checkout@v2
    - name: Deploy DNS zone file
      uses: Achuthananda/akamai-deploy-im-policy-github-action@v2
      env:
        EDGERC: ${{ secrets.EDGERC }}
      with:
        policyList:
          apitest8
          apitest9
        setPolicy: 'achuth-akamaiuniversity-10785535'
        network: staging
```

## License

Copyright 2020 Akamai Technologies, Inc.

See [Apache License 2.0](LICENSE)

By submitting a contribution (the “Contribution”) to this project, and for good and valuable consideration, the receipt and sufficiency of which are hereby acknowledged, you (the “Assignor”) irrevocably convey, transfer, and assign the Contribution to the owner of the repository (the “Assignee”), and the Assignee hereby accepts, all of your right, title, and interest in and to the Contribution along with all associated copyrights, copyright registrations, and/or applications for registration and all issuances, extensions and renewals thereof (collectively, the “Assigned Copyrights”). You also assign all of your rights of any kind whatsoever accruing under the Assigned Copyrights provided by applicable law of any jurisdiction, by international treaties and conventions and otherwise throughout the world.
