#!/bin/bash

# Variables de configuration
DB_NAME="bdr"
DB_USER="postgres"
DB_PASSWORD="root"
SQL_FILE="/docker-entrypoint-initdb.d/GestionDecheterie.sql"

# Exporter le mot de passe pour que psql puisse l'utiliser
export PGPASSWORD=$DB_PASSWORD

# Vérifier si la base de données existe déjà
if psql -U $DB_USER -lqt | cut -d \| -f 1 | grep -qw $DB_NAME; then
    echo "La base de données $DB_NAME existe déjà."
else
    echo "Création de la base de données $DB_NAME..."
    createdb -U $DB_USER $DB_NAME
fi

# Exécuter le fichier SQL pour remplir la base de données
echo "Remplissage de la base de données avec $SQL_FILE..."
psql -U $DB_USER -d $DB_NAME -f $SQL_FILE

echo "Initialisation terminée."
