# SnowTricks (Projet OpenClassRooms)

Ce projet consiste à développer un site web répondant aux besoins spécifiques de Jimmy, en mettant l'accent sur les figures de snowboard. Les fonctionnalités clés à implémenter comprennent :

## Installation

Installer le projet

```bash
  git clone https://github.com/Mozoou/snowtricks_oc.git
```

Installer les dépendances

```bash
    cd snowtricks
    composer install
    npm install
    npm run build
```

Création de la base de données

```bash
    php bin/console d:d:c
    php bin/console d:d:m

```

Executer les données fictives (fixtures)

```bash
    php bin/console d:f:l
```

Lancer le serveur localement

```bash
    php bin/console server:start
```
