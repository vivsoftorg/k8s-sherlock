# K8s-Sherlock 🕵️‍♂️

Overview
--------

K8s-Sherlock is an open-source Kubernetes pod designed for debugging and diagnostics. As a swiss-army knife for your Kubernetes cluster, it comes pre-loaded with a host of tools to help you diagnose issues with network, containers, and more. Developed to expedite the troubleshooting process, K8s-Sherlock is your go-to pod for resolving complex orchestration issues.

---

Features
--------

* **Networking Tools**: Comes with `iproute2`, `iputils-ping`, `traceroute`, `netcat`, `dnsutils`, and `telnet`.
* **HTTP Tools**: `curl` and `wget` pre-installed for HTTP requests.
* **AWS Integration**: AWS CLI is installed for interacting with AWS services.
* **Docker CLI**: Perform Docker operations without leaving the pod.

---

Quick Start
-----------

### Prerequisites

* A Kubernetes cluster up and running
* kubectl installed and configured

### Deploy K8s-Sherlock Pod

bash

```bash
kubectl apply -f pod/sherlock.yaml --namespace=<namespace_name>
```

### Associate Service Account to Pod to AWS IAM role

bash

```bash
kubectl annotate service shelock-sa eks.amazonaws.com/role-arn=<YOUR_IAM_ROLE_ARN> --namespace=<namespace_name>

```

---

Usage
-----

Once the K8s-Sherlock pod is up and running, you can `exec` into it to use the tools.

bash

```bash
kubectl exec -it <pod-name> -- /bin/bash
```

---

Contributing
------------

We love contributions! Please read the [Contributing Guidelines](CONTRIBUTING.MD) for more information on how to get involved.

---

License
-------

This project is licensed under the MIT License. See the [LICENSE](LICENSE.md) file for details.
