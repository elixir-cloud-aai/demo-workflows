# Running `cwl-tes` with S3 storage

`cwl-tes` currently supports only one option of remote storage: FTP. The PR[#38](https://github.com/ohsu-comp-bio/cwl-tes/pull/38) introduces S3 support, which works sufficiently well to run a hashsplitter workflow to completion with S3-compatible storage based on MinIO.

## Prerequisites

### K8s

The example was only ran at minikube. To avoid problems, I ran into, increase the default cpu number to 4, when starting minikube.

### S3

S3-compatible storage was provided with MinIO installed with [the official Operator](https://docs.min.io/minio/k8s/deployment/deploy-minio-operator.html#deploy-operator-kubernetes) into minikube.

Notes from the installation:
There were no issues with installation of the Operator itself.
When deploying the tenant:
- The separate namespace `tesk` was created for the tenant.
- Despite installing the tenant to a one node only K8s, it was necessary to keep the default of 4 servers, each with one volume. The installation of a single server tenant did not work. In order to deploy 4 servers node affinity was disabled (during installation via the console).
- The default TLS was disabled to simplify exposing MinIO to outside of the cluster.

The tenant service was then exposed via an Ingress under the same host name as the service is visible internally within the cluster:
```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: minio-ingress
  namespace: tesk
spec:
  rules:
  - host: "minio.tesk.svc.cluster.local"
    http:
      paths:
      - pathType: Prefix
        path: "/"
        backend:
          service:
            name: minio
            port:
              number: 80
```
There might be more straightforward ways of instaling MinIO into minikube.
Whichever way you install and expose your MinIO service, create a `tesk-1` bucket and upload an example file (`photo.jpg`) to it.

### cwl-tes

Installation of `cwl-tes` with S3 support based on PR#38.
```
#checkout PR
git clone https://github.com/ohsu-comp-bio/cwl-tes.git
git fetch origin pull/38/head:s3
git checkout s3

#install the code...
python setup.py install

#...and the missing requirement
pip install minio
```
Access credentials for the S3 bucket are taken from the environment and should be set via the AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY environment variables.

### TESK

TESK installation with S3 support.
Checkout the TESK Helm chart. Under `s3-config` create `config` file with the contents:
```
[default]
# Non-standard entry, parsed by TESK, not boto3
endpoint_url=http://minio.tesk.svc.cluster.local
```
where `endpoint_url` points to a MinIO URL.
For MinIO installed within the same cluster as TESK, but to a different namespace, you can use the entry as above, where `minio` is the name of MinIO service and `tesk` is the name of the namespace where it is installed.

Under `s3-config` create `credential` file with the contents:
```
[default]
aws_access_key_id=YOUR_KEY
aws_secret_access_key=YOUR_SECRET_KEY
```
Set the values in `values.yaml`:
```
storage: s3
#the URL where TESK is going to be exposed. For local minikube, you can use any name and add an entry to `hosts` file pointing minikube IP to this URL.
host_name: "tesk"
ingress:
    active: true

```
When installing into minikube, enable the ingress addon.
Install the Helm chart.

## DNS tricks for running locally
When running locally on minikube, add your "hosts" defined in Ingress objects for minio and tesk to hosts file:
```
192.168.64.5 tesk
192.168.64.5 minio.tesk.svc.cluster.local
```
The host name as above for minio will ensure that the service is visible under the same URL to `cwl-tes` externally and TESK from within the cluster.
`192.168.64.5` is the example IP of minikube. Check yours by running:
```
minikube ip
```

### Running the example workflow

```
git clone https://github.com/elixir-cloud-aai/demo-workflows.git
cd demo-workflows/hashsplitter-workflow/cwl
```
Replace the contents of `hashsplitter-test.yml` with
```
input:
  class: File
  path: s3://tesk-1/photo.jpg

```
where `tesk-1` is your bucket and `photo.jpg` is an example file you had previously uploaded to the bucket.

Run:
```
cwl-tes --remote-storage-url http://minio.tesk.svc.cluster.local/tesk-1 --tes http://tesk hashsplitter-workflow.cwl hashsplitter-test.yml
```

