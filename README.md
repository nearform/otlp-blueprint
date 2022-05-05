![CI](https://github.com/nearform/bench-template/actions/workflows/ci.yml/badge.svg?event=push)

# Open Telemetry Blueprint
A 3-tier application showcasing [Open Telemetry](https://opentelemetry.io/docs/instrumentation/js/getting-started/) and [Jaeger](https://www.jaegertracing.io/docs/1.21/opentelemetry/) on AWS:

- based on the [NearForm Bench Template](https://github.com/nearform/bench-template)
- simple react front end
- fastify back end
- terraform and terragrunt for the infra (based on the [3-tier architecture recipe](https://github.com/nearform/devops-recipes/tree/main/samples/3-tier))

# Resources
 - [Inspired by this ticket](https://github.com/nearform/bench-draft-issues/issues/81)
 - NearForm's [Open Telemetry Guide](https://github.com/nearform/open-telemetry-guide)
 -  Slack channel: #proj-otlp-blueprint

# Features borrowed from the NearForm Bench Template
A feature-packed template to start a new repository on the bench, including:

- code linting with [ESlint](https://eslint.org) and [prettier](https://prettier.io)
- pre-commit code linting and commit message linting with [husky](https://www.npmjs.com/package/husky) and [commitlint](https://commitlint.js.org/)
- dependabot setup with automatic merging thanks to ["merge dependabot" GitHub action](https://github.com/fastify/github-action-merge-dependabot)
- notifications about commits waiting to be released thanks to ["notify release" GitHub action](https://github.com/nearform/github-action-notify-release)
- PRs' linked issues check with ["check linked issues" GitHub action](https://github.com/nearform/github-action-check-linked-issues)
- Continuous Integration GitHub workflow
