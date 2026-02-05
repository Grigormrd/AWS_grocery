# 🛒 GroceryMate – AWS Cloud Deployment

GroceryMate ist eine containerisierte Webanwendung, die auf AWS betrieben wird.
Das Projekt nutzt **Docker**, **Amazon EC2**, **Amazon RDS (PostgreSQL)** und **Amazon S3** und folgt Best Practices wie **IAM Roles statt statischer AWS-Credentials**.

---

## 🧱 Architektur-Überblick

**Technologien & AWS-Services:**

- Docker – Containerisierung der Anwendung
- Amazon EC2 – Hosting der Anwendung
- Amazon RDS (PostgreSQL) – Persistente Datenbank
- Amazon S3 – Speicherung von Benutzer-Avataren
- AWS IAM Role – Sicherer Zugriff auf S3 ohne Access Keys
- Flask (Python) – Backend

---

## 📦 Projektstruktur

```
.
├── app/
├── avatar/
├── db_backup/
├── logs/
├── run.py
├── manage.py
├── requirements.txt
├── Dockerfile
├── .env.example
└── README.md
```

---

## ⚙️ Voraussetzungen

- AWS Account
- EC2 Instance (Linux)
- Docker installiert
- Amazon RDS PostgreSQL
- Amazon S3 Bucket
- IAM Role mit S3-Zugriff (z. B. AmazonS3FullAccess für Dev)

---

## 🔐 Sicherheit (IAM Role)

Es werden **keine AWS Access Keys** verwendet.

Die EC2-Instance übernimmt eine IAM Role, welche den Zugriff auf S3 erlaubt.
AWS SDKs (boto3) nutzen diese Rolle automatisch.

---

## 🪣 Amazon S3

- Bucket-Name muss global eindeutig sein
- Beispiel: `grocerymate-avatars-grigor`
- Region muss korrekt gesetzt sein (`us-east-1`, `eu-north-1`, etc.)

---

## 🗄️ Amazon RDS (PostgreSQL)

Beispiel-Konfiguration:

```
POSTGRES_HOST=database-1.xxxxx.eu-north-1.rds.amazonaws.com
POSTGRES_DB=grocerymate_db
POSTGRES_USER=grocery_user
POSTGRES_PASSWORD=********
```

---

## 📄 Environment (.env.example)

```
POSTGRES_HOST=
POSTGRES_DB=
POSTGRES_USER=
POSTGRES_PASSWORD=

USE_S3_STORAGE=true
S3_BUCKET_NAME=
S3_REGION=
```

---

## 🐳 Docker Build

```
docker build -t grocerymate .
```

---

## ▶️ Docker Run (EC2)

```
docker run --network host \
  --env-file .env \
  -v $(pwd)/.env:/app/.env \
  -p 5000:5000 \
  grocerymate
```

---

## 🌐 Zugriff

```
http://<EC2_PUBLIC_IP>:5000
```

---

## 🧪 Debugging

```
docker exec -it <container_id> bash
env | grep POSTGRES
env | grep S3_
```

---

## 🚀 Nächste Schritte

- Terraform IaC
- Load Balancer + HTTPS
- CI/CD Pipeline
- CloudWatch Logging

---

## 👤 Autor

GroceryMate – AWS Cloud Project
