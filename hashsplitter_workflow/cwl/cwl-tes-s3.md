# Running `cwl-tes` with S3 storage

`cwl-tes` currently supports only one option of remote storage: FTP. The PR[#38](https://github.com/ohsu-comp-bio/cwl-tes/pull/38) introduces S3 support, which works sufficiently well to run a hashsplitter workflow to completion with S3-compatible storage based on MinIO.

## Prerequisites

### K8s

The example was only ran at minikube. To avoid problems, I ran into, increase the default cpu number to 4, when starting minikube.

### S3

### cwl-tes

Installation if `cwl-tes` with S3 support based on PR#38.
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

### Running the example workflow
