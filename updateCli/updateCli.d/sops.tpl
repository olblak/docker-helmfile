---
title: "[sops] Update version"
sources:
  default:
    kind: githubRelease
    name: Get the latest SOPS version
    spec:
      owner: "mozilla"
      repository: "sops"
      token: "{{ requiredEnv .github.token }}"
      username: "{{ .github.username }}"
      versionFilter:
        kind: semver
        pattern: "~3"
conditions:
  dockerfileArgSopsVersion:
    name: "Does the Dockerfile have an ARG instruction which key is SOPS_VERSION?"
    kind: dockerfile
    spec:
      file: Dockerfile
      instruction:
        keyword: "ARG"
        matcher: "SOPS_VERSION"
  testCstSopsVersion:
    name: "Update the value of SOPS_VERSION in the test harness"
    kind: yaml
    spec:
      file: "cst.yml"
      key: "metadataTest.labels[5].key"
      value: io.jenkins-infra.tools.sops.version
    scm:
      github:
        user: "{{ .github.user }}"
        email: "{{ .github.email }}"
        owner: "{{ .github.owner }}"
        repository: "{{ .github.repository }}"
        token: "{{ requiredEnv .github.token }}"
        username: "{{ .github.username }}"
        branch: "{{ .github.branch }}"
targets:
  updateCstSopsVersion:
    name: "Update the value of SOPS_VERSION in the test harness"
    kind: yaml
    spec:
      file: "cst.yml"
      key: "metadataTest.labels[5].value"
    scm:
      github:
        user: "{{ .github.user }}"
        email: "{{ .github.email }}"
        owner: "{{ .github.owner }}"
        repository: "{{ .github.repository }}"
        token: "{{ requiredEnv .github.token }}"
        username: "{{ .github.username }}"
        branch: "{{ .github.branch }}"
  updateDockerfileArgSopsVersion:
    name: "Update the value of ARG SOPS_VERSION in the Dockerfile"
    kind: dockerfile
    spec:
      file: Dockerfile
      instruction:
        keyword: "ARG"
        matcher: "SOPS_VERSION"
    scm:
      github:
        user: "{{ .github.user }}"
        email: "{{ .github.email }}"
        owner: "{{ .github.owner }}"
        repository: "{{ .github.repository }}"
        token: "{{ requiredEnv .github.token }}"
        username: "{{ .github.username }}"
        branch: "{{ .github.branch }}"
