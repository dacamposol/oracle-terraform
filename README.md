# Oracle OKE Terraform

This repository contains the required Terraform scripts to set up K8s using OKE in the Oracle Free Tier.

## Requirements

| Variable | Definition |
| -------- | ---------------- |
| `region` | Value of the region where we want to deploy the cluster |
| `tenancy_ocid` | Value of the root Compartment OCID |
| `user_ocid` | Value of the User OCID |
| `user_rsa_path` | Path where we store the generated RSA key, better to use `~/.oci/oci-rsa.pem` |
| `user_rsa_fingerprint` | After generating the RSA Keys, we can consult the fingerprint in the Oracle Cloud Console |

### OCI CLI

We will require from the OCI CLI to access to our created Kubernetes Cluster, so this should be installed.

Instructions on how to install the OCI CLI for different environments can be found [here](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/cliinstall.htm).

### Kubectl

In order to interact with our K8s Cluster using the Kubernetes API, we require the command-line tool for Kubernetes: `kubectl`.

How to install it in different environments is available in [here](https://kubernetes.io/docs/tasks/tools/#kubectl)

### RSA Keys

In order to be able to run this scripts against OCI (Oracle Cloud Infrastructure), you have to create and import RSA Keys for API signing.

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

6. Modify the file under `$HOME/.oci/config` and add the following keys:

```text
tenancy=<tenancy_ocid>
user=<user_ocid>
region=<region>
key_file=<user_rsa_path>
fingerprint=<user_rsa_fingerprint>
```

## Usage

First, override all the variables by using a file in the root directory of our Terraform scripts with the defined variables in the [Requirement](#requirements) section with the name `env.tfvars`.

Then, in order to create the cluster, just run the following:

```shell
terraform apply -var-file="env.tfvars"
```

Check that everything is correct, and type `yes` on the required input. In some minutes, the cluster will be ready and a `kubeconfig` will be placed in the folder `generated`.

In order to start using this cluster, you can just:

- Move the kubeconfig to the default location of `$HOME/.kube/config`

```shell
mv /generated/kubeconfig ~/.kube/config
```

- Export the `KUBECONFIG` environment variable to our current location

```shell
export KUBECONFIG=$(pwd)/generated/kubeconfig
```