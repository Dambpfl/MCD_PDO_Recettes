-- Afficher toutes les recettes disponibles dans lordre decroissant du temps de prepa
SELECT recipe_name, category_name, preparation_time  
FROM recipe
INNER JOIN category ON recipe.id_category = category.id_category
ORDER BY preparation_time DESC;

-- Fait apparaitre le nb dingredients par recette
SELECT recipe_name, COUNT(id_ingredient)
FROM recipe
INNER JOIN recipe_ingredients ON recipe.id_recipe = recipe_ingredients.id_recipe
GROUP BY recipe_name;

-- Afficher les recettes de moins de 30min
SELECT recipe_name, preparation_time 
FROM recipe
WHERE preparation_time < 30;

-- Afficher les recettes dont le nom contient salade
SELECT recipe_name
FROM recipe
WHERE recipe_name LIKE "%Salade%" -- "Salade%" marche aussi dans mon cas, maj pas obligatoire

-- Insérer une nouvelle recette pates a la carbonara prepa 20min
INSERT INTO recipe (recipe_name, preparation_time, instructions, id_category) -- ("*" ne fonctionne pas)
VALUES ("Pâtes à la carbonara", 20, "Cuire les pates", 2) -- bien respecter l'ordre -- Verif avec SELECT * FROM recipe

-- Modifier le nom de la recette id3
UPDATE recipe
SET recipe_name = "Poulet curry" -- maj de recipe_name
WHERE id_recipe = 3  -- id à changer

-- Supprimer la recette numero 2
DELETE FROM recipe_ingredients -- enfant de recipe obliger de la supprimer avant
WHERE id_recipe = 2;
 
puis
 
DELETE FROM recipe -- supprimer le parent
WHERE id_recipe = 2

-- Afficher le prix total de la recette 5
SELECT recipe.id_recipe, recipe_name, SUM(ingrediant.price*recipe_ingredients.quantity)
FROM recipe
INNER JOIN recipe_ingredients ON recipe.id_recipe = recipe_ingredients.id_recipe
INNER JOIN ingrediant ON recipe_ingredients.id_ingredient = ingrediant.id_ingrediant
WHERE recipe.id_recipe = 5
GROUP BY recipe.id_recipe, recipe.recipe_name


-- Afficher le detail de la recette 5
SELECT recipe_name, ingrediant_name, quantity, unity, price
FROM recipe
INNER JOIN recipe_ingredients ON recipe.id_recipe = recipe_ingredients.id_recipe
INNER JOIN ingrediant ON recipe_ingredients.id_ingredient = ingrediant.id_ingrediant
WHERE recipe.id_recipe = 5


-- Ajouter un ingredient Poivre, unité cuillère à café + prix
INSERT INTO ingrediant (ingrediant_name, price)
VALUES ("Poivre", 0.4)

-- Modifier le prix de lingredient 12
UPDATE ingrediant
SET price = 1.4
WHERE id_ingrediant = 12

-- Afficher le nombre de recette par catégorie (entrée,plat,dessert)
SELECT category.category_name, COUNT(recipe.id_recipe)
FROM category
INNER JOIN recipe ON category.id_category = recipe.id_category
GROUP BY category_name

-- Afficher les recettes qui contiennent l'ingrédient Poulet
SELECT recipe_name
FROM recipe
WHERE recipe_name LIKE "%Poulet%"

-- Met à jour le temps de prépa de toute les recettes de -5 min
UPDATE recipe
SET preparation_time = preparation_time - 5 -- NE PAS OUBLIER DE SOUSTRAIRE A LA VALEUR ACTUEL

-- Affiche les recettes sans ingrédients coutant + de 2€
SELECT recipe_name -- sélectionne toutes les recettes qui ne sont pas (NOT IN) concernées 
FROM recipe
WHERE id_recipe NOT IN (
	SELECT id_recipe -- récupère toutes les recettes dont au moins un ingrédient coûte 2 euros 
	FROM recipe_ingredients
	INNER JOIN ingrediant ON recipe_ingredients.id_ingredient = ingrediant.id_ingrediant
	WHERE recipe_ingredients.id_recipe = recipe.id_recipe -- extrait la ligne si id recipe = & price > 2
	AND ingrediant.price > 2 );

-- Affiche la recette plus rapide a preparé
SELECT recipe_name, preparation_time
FROM recipe
WHERE preparation_time = (SELECT MIN(preparation_time) FROM recipe)

-- trouver les recettes qui nécessitent aucun ingredient
SELECT recipe_name
FROM recipe
WHERE id_recipe NOT IN ( -- filtre les recettes qui n'ont pas d'ingredient
	SELECT id_recipe
	FROM recipe_ingredients);

-- trouve les ingredients utilisés dans au moins 3 recettes
SELECT ingrediant_name, COUNT(recipe_ingredients.id_recipe)
FROM ingrediant
INNER JOIN recipe_ingredients ON ingrediant.id_ingrediant = recipe_ingredients.id_ingredient
GROUP BY ingrediant.id_ingrediant
HAVING COUNT(recipe_ingredients.id_recipe) >= 3;

-- ajouter un ingredient a une recette
INSERT INTO recipe_ingredients (quantity, unity, id_ingredient, id_recipe)
VALUES (1, "L", 5, 1); -- Insert 1 litre de (id=5)Sauce César dans (id=1)Salade césar

-- trouve la recette la plus couteuse de la base de données
SELECT recipe.id_recipe, recipe_name, SUM(ingrediant.price*recipe_ingredients.quantity) AS total
FROM recipe
INNER JOIN recipe_ingredients ON recipe.id_recipe = recipe_ingredients.id_recipe
INNER JOIN ingrediant ON recipe_ingredients.id_ingredient = ingrediant.id_ingrediant
WHERE recipe.id_recipe
GROUP BY recipe.id_recipe, recipe.recipe_name 
ORDER BY total DESC
LIMIT 1                          --- 1ère façon de faire pour afficher la recette la plus couteuse



SELECT recipe.id_recipe, recipe.recipe_name,  -- 2è façon de faire pour afficher la recette la plus couteuse
       SUM(ingrediant.price * recipe_ingredients.quantity) AS total
FROM recipe
INNER JOIN recipe_ingredients ON recipe.id_recipe = recipe_ingredients.id_recipe
INNER JOIN ingrediant ON recipe_ingredients.id_ingredient = ingrediant.id_ingrediant
GROUP BY recipe.id_recipe, recipe.recipe_name
HAVING total = (    --sous requete        --Cette requête sélectionne la ou les recettes dont le prix total des ingrédients est le plus élevé                               
    SELECT MAX(total_price)                 -- en comparant le total de chaque recette avec le maximum calculé dans une sous-requête
    FROM (
        SELECT SUM(ingrediant.price * recipe_ingredients.quantity) AS total_price -- sous-sous requete
        FROM recipe
        INNER JOIN recipe_ingredients ON recipe.id_recipe = recipe_ingredients.id_recipe
        INNER JOIN ingrediant ON recipe_ingredients.id_ingredient = ingrediant.id_ingrediant
        GROUP BY recipe.id_recipe
    ) AS subquery -- Nom de la sous-sous requete obligatoire -- subquery représente le calcul du prix total maximum des recettes
);

-- TABLE VIRTUEL (creation)
CREATE VIEW recettepluschere AS 
 SELECT recipe_name, SUM(ingrediant.price * recipe_ingredients.quantity) AS prixTotal
 FROM recipe
 
 INNER JOIN recipe_ingredients ON recipe.id_recipe = recipe_ingredients.id_recipe
 INNER JOIN ingrediant ON recipe_ingredients.id_ingredient = ingrediant.id_ingrediant
 
 GROUP BY recipe_name

-- UTILISATION
SELECT recipe_name, prixTotal
FROM recettepluschere
WHERE prixTotal = (SELECT MAX(prixTotal) FROM recettepluschere)