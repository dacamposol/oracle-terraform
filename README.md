# Oracle OKE Terraform

This repository contains the **Terraform** scripts to bootstrap a Kubernetes Cluster in the **Oracle Cloud Infrastructure Free Tier** with **Oracle Kubernetes Engine (OKE)**.

Additionally, **ArgoCD** will be installed in the bootstrapped cluster for GitOps management of the cluster resources.

## Requirements

### Variables

This variables don't have default declared values and are required to be provided to the scripts.

Create a `.tfvars` file in the root folder of this repository with the following variables declared:

| Variable | Definition |
| -------- | ---------------- |
| `region` | Value of the region where we want to deploy the cluster |
| `tenancy_ocid` | Value of the root Compartment OCID |
| `user_ocid` | Value of the User OCID |
| `user_rsa_path` | Path where we store the generated RSA key, better to use `~/.oci/oci-rsa.pem` |
| `user_rsa_fingerprint` | After generating the RSA Keys, we can consult the fingerprint in the Oracle Cloud Console |

Other variables, which are not mandatory, can be provided in this file as well. For a complete description of all the variables, check the contents on the [variables.tf file](variables.tf).

### Oracle Cloud Infrastructure (OCI) Access

In order to be able to perform operations against OCI, we need to create and import an RSA Key for API signing.

This can be easily performed with the following steps:

1. Make an `.oci` directory on your home folder:

```shell
$ mkdir $HOME/.oci
```

2. Generate a 2048-bit private key in a PEM format:

```shell
$ openssl genrsa -out $HOME/.oci/oci-rsa.pem 2048
```

3. Change permissions, so only you can read and write to the private key file:

```shell
$ chmod 600 $HOME/.oci/oci-rsa.pem
```

4. Generate the public key:

```shell
$ openssl rsa -pubout -in $HOME/.oci/oci-rsa.pem -out $HOME/.oci/oci-rsa-public.pem
$ cat $HOME/.oci/oci-rsa-public.pem
```

5. Add the public key to your OCI user account from `User Settings > API Keys`

### Oracle Cloud Infrastructure (OCI) CLI

We need a correctly configured OCI CLI to log against our to-be-created Kubernetes Cluster, as we will use the K8s login plugin to get a JWT for access.

Instructions on how to install the OCI CLI for different environments can be found [here](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/cliinstall.htm).

Once we have installed the tool, we need to configure it to use the previously generated RSA Key to interact with out OCI Tenancy. In order to do that, we are going to create (or modify if it has been automatically created) the file `$HOME/.oci/config` with the following keys:

```text
tenancy=<tenancy_ocid>
user=<user_ocid>
region=<region>
key_file=<user_rsa_path>
fingerprint=<user_rsa_fingerprint>
```

How to retrieve these values is explained in the [variables section](#variables).

### Kubernetes Command-Line Tool

In order to interact with our K8s Cluster using the Kubernetes API, we require a Kubernetes CLI; at this point, it's on your choice whether to use install the official CLI from Kubernetes (`kubectl`) or some other CLI tool as K9s (as I personally use).

- How to install `kubectl` in different environments is available in [here](https://kubernetes.io/docs/tasks/tools/#kubectl)
- How to install `k9s` in different environments is available in [here](https://k9scli.io/topics/install/)

## Usage

First, override all the variables by using a file in the root directory of our Terraform scripts with the defined variables in the [Requirement](#requirements) section with the name `env.tfvars`.

Then, in order to create the cluster, just run the following:

```shell
$ terraform apply -var-file="env.tfvars"
```

Check that everything is correct, and type `yes` on the required input. In some minutes, the cluster will be ready and a `kubeconfig` will be placed in the folder `generated`.

In order to start using this cluster, you can just export the `KUBECONFIG` environment variable to our current location and use your desired Kubernetes CLI Tool.

```shell
$ export KUBECONFIG=$(pwd)/generated/kubeconfig
$ k9s
```

## Author

Daniel Campos Olivares, 2022

**Links:**
- [StackOverflow](https://stackoverflow.com/users/8951571/daniel-campos-olivares)
- [Twitter](https://www.twitter.com/devcamposol/)
- [LinkedIn](https://www.linkedin.com/in/dacamposol/)