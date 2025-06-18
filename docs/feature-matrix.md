# Bandstand Charts Feature Matrix

This matrix compares the features available across all Bandstand Helm charts.

| Feature/Chart                | web-service | headless-service | cron-job | job | triggered-job | test-runner | confluent-connect |
|------------------------------|:-----------:|:----------------:|:--------:|:---:|:-------------:|:-----------:|:-----------------:|
| Image config                 |      ✓      |        ✓         |    ✓     |  ✓  |      ✓        |      ✓      |        ✓          |
| Resource requests/limits     |      ✓      |        ✓         |    ✓     |  ✓  |      ✓        |      ✓      |        ✓          |
| Environment variables        |      ✓      |        ✓         |    ✓     |  ✓  |      ✓        |      ✓      |        ✓          |
| Secrets/ConfigMaps           |      ✓      |        ✓         |    ✓     |  ✓  |      ✓        |      ✓      |        ✓          |
| Persistent volumes           |      ✓      |        ✓         |    ✓     |  ✓  |      ✓        |      ✗      |        ✗          |
| Ephemeral volumes            |      ✓      |        ✓         |    ✓     |  ✓  |      ✓        |      ✗      |        ✗          |
| S3 volumes                   |      ✗      |        ✗         |    ✓     |  ✗  |      ✗        |      ✗      |        ✗          |
| Service exposure             |      ✓      |        ✓         |    ✗     |  ✗  |      ✗        |      ✗      |        ✓          |
| Ingress support              |      ✓      |        ✗         |    ✗     |  ✗  |      ✗        |      ✗      |        ✓          |
| HPA/Scaling                  |      ✓      |        ✓         |    ✗     |  ✗  |      ✓        |      ✗      |        ✓          |
| Advanced scaling             |      ✓      |        ✓         |    ✗     |  ✗  |      ✗        |      ✗      |        ✗          |
| AZ balancing                 |      ✓      |        ✓         |    ✗     |  ✗  |      ✗        |      ✗      |        ✗          |
| Node selectors/tolerations   |      ✓      |        ✓         |    ✗     |  ✗  |      ✗        |      ✗      |        ✗          |
| Probes (liveness/readiness)  |      ✓      |        ✓         |    ✗     |  ✗  |      ✗        |      ✗      |        ✗          |
| Test hooks                   |      ✗      |        ✗         |    ✗     |  ✗  |      ✗        |      ✓      |        ✗          |
| Connector mgmt (Kafka)       |      ✗      |        ✗         |    ✗     |  ✗  |      ✗        |      ✗      |        ✓          |
| Cron scheduling              |      ✗      |        ✗         |    ✓     |  ✗  |      ✗        |      ✗      |        ✗          |
| SQS trigger                  |      ✗      |        ✗         |    ✗     |  ✗  |      ✓        |      ✗      |        ✗          |
| Job history/limits           |      ✗      |        ✗         |    ✓     |  ✓  |      ✓        |      ✗      |        ✗          |
| Test runs                    |      ✗      |        ✗         |    ✗     |  ✗  |      ✗        |      ✓      |        ✗          |

Legend: ✓ = Supported, ✗ = Not supported

See the [Chart Features Guide](./chart-features-guide.md) for detailed explanations and usage notes.
