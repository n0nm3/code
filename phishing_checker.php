<?php

function connectDB() {
    $host = "localhost"; 
    $username = "user_phishing"; 
    $password = "password"; 
    $dbname = "phishing_db"; 

    $conn = new mysqli($host, $username, $password, $dbname);

    // Vérifier la connexion
    if ($conn->connect_error) {
        die("Erreur de connexion à la base de données : " . $conn->connect_error);
    }

    return $conn;
}

// Fonction pour vérifier si le lien est un phishing
function checkPhishingLink($link) {
    // Connexion à la base de données
    $conn = connectDB();

    // Échapper les caractères spéciaux pour éviter les injections SQL
    $link = $conn->real_escape_string($link);

    // Requête SQL pour vérifier si le lien est dans la base de données
    $sql = "SELECT * FROM link WHERE lien = '$link'";
    $result = $conn->query($sql);

    // Si le lien est trouvé dans la base de données, c'est un phishing
    if ($result->num_rows > 0) {
        return true;
    } else {
        return false;
    }

    // Fermer la connexion à la base de données
    $conn->close();
}

// Vérifier si un lien a été soumis
if (isset($_POST['link'])) {
    $link = $_POST['link'];

    // Vérifier si le lien est un phishing
    $isPhishing = checkPhishingLink($link);

    // Si phishing, alors on le dit
    if ($isPhishing) {
        echo "Attention ! Ce lien est suspect.";
    } else {
        echo "Ce lien semble sûr.";
    }
}
?>
