# GlucoCoach 1.0

GlucoCoach is a Java-based application for managing health data, integrated with Nightscout.

## Deployment

### Automated Deployment (GitHub Actions)

This project uses GitHub Actions for CI/CD. The workflow is defined in `.github/workflows/deploy.yml`.

#### Prerequisites
To use the automated deployment, you must configure the following **Secrets** in your GitHub repository (`Settings > Secrets and variables > Actions`):

| Secret | Description |
| --- | --- |
| `VPS_HOST` | The IP address or domain name of your VPS. |
| `VPS_USERNAME` | The SSH username for your VPS (e.g., `root` or `ubuntu`). |
| `VPS_SSH_KEY` | Your private SSH key used to connect to the VPS. |

#### Workflow Details
The pipeline performs the following steps on every push to the `main` branch:
1. **Build and Test**: Compiles the Java code and runs Maven tests.
2. **Build and Push Docker Image**: Builds a Docker image using `backend/Dockerfile` and pushes it to the GitHub Container Registry (GHCR).
3. **Deploy to VPS**: 
    - Connects to the VPS via SSH.
    - Clones or updates the repository in `~/opt/glucocoach`.
    - Logs into GHCR.
    - Pulls the latest image and restarts the services using `docker compose`.

---

### Manual Deployment

If the automated deployment fails, you can deploy manually by following these steps on your VPS:

1. **Clone the repository** (if not already done):
   ```bash
   git clone https://github.com/YOUR_USERNAME/glucocoach1.0.git ~/opt/glucocoach
   cd ~/opt/glucocoach
   ```

2. **Pull the latest changes**:
   ```bash
   git pull origin main
   ```

3. **Build and start the containers**:
   ```bash
   docker compose up -d --build
   ```

4. **Verify the services are running**:
   ```bash
   docker compose ps
   ```

## Development

### Prerequisites
- Java 21
- Docker and Docker Compose

### Running Locally
To start the entire stack locally:
```bash
docker compose up -d
```
The API will be available at `http://localhost:8080`.
Nightscout will be available at `http://localhost:1337`.

### Running Tests
To run tests locally:
```bash
cd backend
mvn clean verify
```
