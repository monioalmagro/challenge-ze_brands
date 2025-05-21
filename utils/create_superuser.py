from django.contrib.auth import get_user_model
import logging

logger = logging.getLogger(__name__)

User = get_user_model()
if not User.objects.filter(username='admin').exists():
    User.objects.create_superuser('admin', 'admin@example.com', 'admin123')
    logger.info("Created superuser with username 'admin'")
else:
    logger.info("Superuser with username 'admin' already exists")
