# Code Journey
## Description
Modern software development goes well beyond just writing code for your application. It is well known that we spend more time maintaining applications than developing them, so the industry has developed some techniques and workflows to make the maintenance easier. Those include continuous integration and continuous delivery, release orchestration, and observability.

## Objectives
In this journey, you are going to instrument our application to benefit from those workflows, given the available platforms. You will containerize a web app of your choice (a small web API is more than enough), deploy it in Kubernetes using ArgoCD, and have it write logs, traces, and collect metrics.

The app should be deployed automatically after the approval of a Pull Request on the repository with a build and test process managed by Jenkins and using ArgoCD to deploy the app into Kubernetes. We should see metrics, logs, and traces on the respective dashboards.

The above requirements are the very least that should be accomplished by the group.

In order to improve your grade you must add value to the solution, per example you should adopt whenever possible infrastructure as code.

## How to begin
In order to deploy the platforms, you need to have [Docker](https://www.docker.com/products/docker-desktop/), a Kubernetes cluster running locally (we recommend [kind](https://kind.sigs.k8s.io/)), and [Helm](https://helm.sh/) to install packages. Then run the commands listed in the [instructions](/instructions.md) to deploy each piece of the system.

Your application code can be in a separate repository than this one. If you can't provide an application, we will provide one for you.
