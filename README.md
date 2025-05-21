# ze_brands Challenge

**Author:** Emiliano Mazzurque  
emazzurque@gmail.com

API developed with **Django** and **GraphQL** for managing products, brands, and users. Includes JWT authentication, visitor tracking, and email notifications.

---

## 🚀 Quickstart

### 1. Clone the repository

```sh
git clone <repo-url>
cd challenge-ze_brands
```

### 2. Start the project with Docker

Build and run the services (Django + Redis):

```sh
make up
```

Apply database migrations:

```sh
make migrate
```

To stop and remove the services:

```sh
make down
```

---

## 🧑‍💻 GraphQL Mutation Examples

### Create initial user

Run the following command to create a test admin user:

```sh
make init
```

### Access the GraphQL Playground

- [http://localhost:8000/graphql/](http://localhost:8000/graphql/)

### Get JWT token

```graphql
mutation {
  tokenAuth(username: "admin", password: "admin123") {
    token
  }
}
```
> Save the token to authenticate future requests.

### Create a BRAND

```graphql

mutation {
  createBrand(
    input: {
      name: "Acme Corp"
      description: "Leading provider of innovative gadgets."
    }
  ) {
    success
    brand {
      id
      originalId
      name
      description
    }
    message
  }
}
```

### Create a product

```graphql
mutation {
  createProduct(input: {name: "TV", price: 1000, brandId: 1}) {
    success
    product { id name price }
    message
  }
}
```

### Update a user

```graphql
mutation {
  updateUser(input: {userId: 1, email: "new@mail.com"}) {
    success
    user { id username email }
    message
  }
}
```

---

## ⚙️ Manual setup (optional, without Docker)

```sh
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
python manage.py migrate
python manage.py createsuperuser
python manage.py runserver
```

---

## 🌐 API Access

- **GraphQL Playground:** [http://localhost:8000/graphql/](http://localhost:8000/graphql/)
- **Django Admin:** [http://localhost:8000/admin/](http://localhost:8000/admin/)

---

## 🏗️ Main Features

- Full CRUD for **Users**, **Brands**, and **Products** via GraphQL.
- Secure **JWT authentication**.
- **Anonymous visitor tracking** (stored in Redis).
- **Email notifications** on product updates (Amazon SES).
- **Testing** with pytest and Django test client.
- **Code quality**: Black, isort, and flake8.

---

## 📁 Project Structure

- `apps/` – Django apps: `customuser`, `product`, `visitor`
- `schema/` – GraphQL schema and mutations
- `observer/` – Observer pattern for notifications
- `utils/` – Utilities (email, tracking, etc.)
- `test/` – Tests with pytest
- `docker-compose.yaml` – Docker services (web, redis)
- `Makefile` – Useful development commands

---

## ⚙️ Configuration and Environment

- **Database:** SQLite (default, see `ze_brands/settings.py`)
- **Redis:** For visitor tracking (see Docker Compose)
- **Amazon SES:** For sending emails (configure credentials in `ze_brands/settings.py`)

---

## 🧪 Testing

All main features are covered by tests in [`test/`](test/).

Run all tests with:

```sh
make test
```

---

## 🧹 Linting & Formatting

To check and autoformat the code:

```sh
make linters
```

---
## 🏛️ Architecture and Scalability

### Architecture Design

- **Django + GraphQL:** Main API for managing products, brands, and users.
- **Database (SQLite by default):** Stores core entities. Can be easily migrated to PostgreSQL for production.
- **Redis:** Stores anonymous product visit counts, allowing for fast and scalable queries.
- **Amazon SES:** External service for sending email notifications to administrators when a product is modified.
- **Docker Compose:** Orchestrates application services and Redis to facilitate development and deployment.
- **JWT:** Secure authentication for admins and protection of sensitive endpoints.

[User] ──▶ [Django + GraphQL API] ──▶ [Database]
│                      │
│                      └──▶ [Redis] (visit tracking)
│
└──▶ [Amazon SES] (email notifications to admins)


### Future Scalability

- **Database:** Migrate to PostgreSQL or a managed service (e.g., AWS RDS) for greater robustness and performance.
- **Redis:** Can scale horizontally to support higher tracking traffic.
- **Emails:** Use queues (Celery + Redis) to process notifications asynchronously and decoupled.
- **API:** Deploy multiple Django instances behind a load balancer (e.g., Nginx, AWS ELB).
- **Containerization:** Facilitates deployment to services like AWS ECS, Kubernetes, Heroku, etc.
- **Caching:** Implement caching for frequent product queries.
- **Monitoring:** Add tools like Sentry, Prometheus for centralized monitoring and logging.

---