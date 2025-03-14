Bienvenue sur myGest_IOnR !

Installation

Pour un premier lancement, il est nécessaire de procéder à l'installation. Pour ce faire, exécutez une première fois le script "myGestIOnR.sh" ou exécutez manuellement "/install/install.sh"
⚠️ Vous devez être connecté en tant que root !


Paramètres d'installation :

Lors de l'installation, vous devrez renseigner :
	- Un nom d'utilisateur qui vous identifiera.
	- Si votre machine est un client ou un serveur (0 pour client, 1 pour serveur).
	- Si vous souhaitez activer le mode daltonien (0 pour non, 1 pour oui).

L'ensemble de ces informations sera enregistré dans un fichier config.sh, indispensable au fonctionnement du programme.



Installation des paquets :

Serveur (1):
Si vous installez myGest_IOnR sur un serveur, les paquets suivants seront installés :
	- mariadb-server (pour la base de données)
	- figlet (pour l'affichage des titres)

Client (0):
Si vous installez myGest_IOnR sur un client, les paquets suivants seront installés :
	- mariadb-server (pour la base de données)
	- figlet (pour l'affichage des titres)
	- lolcat (pour l'affichage en couleur des titres)
	- Configuration de la base de données



L'installateur va :
	- Créer la base de données "MyGest"
	- Créer l'utilisateur "Gest" et lui attribuer tous les droits
	- Importer les tables et les valeurs initiales nécessaires au bon fonctionnement du programme


⚠️ Remarque importante !

Si vous avez déjà installé l'ensemble des éléments nécessaires, veuillez commenter la ligne "bash install/install.sh" dans "myGestIOnR.sh" pour éviter une réinstallation.


Le but de ce programme est de permettre une gestion simplifiée d'un parc informatique. Il offre la possibilité d'afficher les machines enregistrées, de vérifier leur état (actives ou non)
et d'accéder à un outil simple, accessible et guidé étape par étape. Pour assurer le bon fonctionnement du programme, il suffit de suivre les instructions fournies.

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
English Version

Welcome to myGest_IOnR!

Installation

For the first launch, you must proceed with the installation. To do so, run the script myGestIOnR.sh once or manually execute "/install/install.sh"
⚠️ You must be logged in as root!

Installation Parameters :

During the installation, you will need to provide:
	- A username to identify yourself.
	- Whether your machine is a client or a server (0 for client, 1 for server).
	- Whether you want to enable colorblind mode (0 for no, 1 for yes).

All these settings will be saved in the config.sh file, which is required for the program to function.



Package Installation :

Server (1):
If you install myGest_IOnR on a server, the following packages will be installed:
	- mariadb-server (for the database)
	- figlet (for title display)

Client (0):
If you install myGest_IOnR on a client, the following packages will be installed:
	- mariadb-server (for the database)
	- figlet (for title display)
	- lolcat (for colored title display)



The installer will:
	- Create the "MyGest" database
	- Create the "Gest" user and grant full access
	- Import the necessary tables and initial values for the program

⚠️ Important Note

If you have already installed all required components, please comment "bash install/install.sh" line in "myGestIOnR.sh" to prevent reinstallation.


The purpose of this program is to provide a simplified way to manage an IT infrastructure. It allows users to display registered machines, check their status (active or not),
and access a simple, accessible, and step-by-step guided tool. To ensure the proper execution of the program, simply follow the provided instructions.
