INSERT INTO public.categories (id,name,slug,description) VALUES
	 ('87e13b61-759d-4ed0-8b4d-cc63b55e9847'::uuid,'Plantes d''intérieur','plantes-interieur','Plantes adaptées à la vie en intérieur, faciles à entretenir.'),
	 ('b77bc472-bba4-4ac5-88b3-e6701c1c0ca6'::uuid,'Plantes d''extérieur','plantes-exterieur','Plantes conçues pour le jardin ou le balcon.'),
	 ('d0cf8e6e-b8ec-49b1-8f60-0c9ac28d4cbd'::uuid,'Plantes grasses','plantes-grasses','Plantes succulentes capables de stocker l''eau.'),
	 ('6a40d6ed-7aa3-46d4-ae42-b5f568791343'::uuid,'Cactus','cactus','Plantes piquantes résistantes à la sécheresse.'),
	 ('0aa16bed-c4a4-43d9-a84a-a45a34c3f422'::uuid,'Fougères','fougeres','Plantes vertes sans fleurs, au feuillage décoratif.'),
	 ('7a6dce61-0d2d-4eac-9878-214d68913dd3'::uuid,'Orchidées','orchidees','Plantes tropicales aux fleurs élégantes.'),
	 ('dc2fd599-d655-4897-8549-58169034f42c'::uuid,'Plantes à fleurs','plantes-a-fleurs','Plantes produisant des fleurs colorées.'),
	 ('ea1d8a50-f654-48bb-a70d-19cf3e61f3e1'::uuid,'Plantes aromatiques','plantes-aromatiques','Herbes utilisées en cuisine ou en infusion.'),
	 ('9f34969c-f923-49e5-ab1e-941d47311c03'::uuid,'Plantes médicinales','plantes-medicinales','Plantes reconnues pour leurs vertus curatives.'),
	 ('5f50f744-f03c-4a8a-8211-017645f26e1e'::uuid,'Plantes carnivores','plantes-carnivores','Plantes se nourrissant d''insectes.');
INSERT INTO public.categories (id,name,slug,description) VALUES
	 ('3a30d5d5-9be5-4be2-8e5a-72b2a629eab4'::uuid,'Plantes grimpantes','plantes-grimpantes','Plantes qui grimpent sur des supports.'),
	 ('ed29e648-7fb2-4fad-bfe0-4083c9564455'::uuid,'Plantes aquatiques','plantes-aquatiques','Plantes qui poussent dans ou autour de l''eau.'),
	 ('653d010d-cd02-453c-ad5e-0f5f056361ce'::uuid,'Arbustes','arbustes','Plantes ligneuses de petite taille.'),
	 ('87a0d49f-f4f0-4810-9700-7a8a52c97c8f'::uuid,'Arbres','arbres','Plantes ligneuses de grande taille.'),
	 ('7e0f9a17-4c2e-49bb-877e-c22efb680198'::uuid,'Bonsaïs','bonsais','Arbres miniatures cultivés en pot.'),
	 ('fe0a5381-ce36-459c-9539-24bbead03f7a'::uuid,'Plantes tropicales','plantes-tropicales','Plantes issues des régions chaudes et humides.'),
	 ('f6518f36-d82c-4ee8-9b1c-53b6cf745861'::uuid,'Plantes vivaces','plantes-vivaces','Plantes qui repoussent chaque année.'),
	 ('79bbe6df-7003-4ee8-b628-48ee844c4cef'::uuid,'Plantes annuelles','plantes-annuelles','Plantes qui complètent leur cycle en un an.'),
	 ('67fb39fa-db38-4917-a30d-94c117f0319b'::uuid,'Bulbes','bulbes','Plantes poussant à partir de bulbes.'),
	 ('5e6bd164-350c-42dc-8f6e-1acc3958ff7b'::uuid,'Plantes couvre-sol','plantes-couvre-sol','Plantes qui s''étendent au ras du sol.');
INSERT INTO public.categories (id,name,slug,description) VALUES
	 ('1d20bcff-f33a-458f-8cf1-dff4ec1828d9'::uuid,'Herbes ornementales','herbes-ornementales','Graminées décoratives pour jardin et terrasse.'),
	 ('684822b9-7095-41c8-80f4-0d72c275195d'::uuid,'Plantes alpines','plantes-alpines','Plantes adaptées aux climats froids de montagne.'),
	 ('4eca59c1-e0a7-468b-ba6a-2705b582c93d'::uuid,'Plantes de haies','plantes-de-haies','Plantes utilisées pour former des haies.'),
	 ('4964b9b8-f858-45c3-91ca-0455a40ab94b'::uuid,'Plantes fruitières','plantes-fruitieres','Plantes qui produisent des fruits comestibles.'),
	 ('82c5dfe7-c830-40bb-b8db-6c67e3472ad0'::uuid,'Lianes','lianes','Plantes à longues tiges souples, souvent grimpantes.'),
	 ('5fbd6a7c-5fca-4d6b-b8d9-b34d80cf306e'::uuid,'Fleurs sauvages','fleurs-sauvages','Plantes florales poussant naturellement en liberté.');

  
INSERT INTO subcategories (name, description, slug, category_id) VALUES
-- Plantes d'intérieur
('Plantes vertes', 'Plantes décoratives sans fleurs, faciles à entretenir.', 'plantes-vertes', '87e13b61-759d-4ed0-8b4d-cc63b55e9847'),
('Plantes suspendues', 'Plantes d''intérieur à suspendre pour un effet décoratif.', 'plantes-suspendues', '87e13b61-759d-4ed0-8b4d-cc63b55e9847'),
('Mini plantes', 'Plantes de petite taille parfaites pour les petits espaces.', 'mini-plantes', '87e13b61-759d-4ed0-8b4d-cc63b55e9847'),

-- Plantes d'extérieur
('Plantes rustiques', 'Plantes résistantes aux intempéries et au gel.', 'plantes-rustiques', 'b77bc472-bba4-4ac5-88b3-e6701c1c0ca6'),
('Graminées ornementales', 'Plantes herbacées utilisées pour le jardin.', 'graminees-ornementales', 'b77bc472-bba4-4ac5-88b3-e6701c1c0ca6'),
('Vivaces extérieures', 'Plantes vivaces adaptées au plein air.', 'vivaces-exterieures', 'b77bc472-bba4-4ac5-88b3-e6701c1c0ca6'),

-- Plantes grasses
('Echeveria', 'Plantes grasses en forme de rosette.', 'echeveria', 'd0cf8e6e-b8ec-49b1-8f60-0c9ac28d4cbd'),
('Sedum', 'Plantes grasses rampantes ou dressées.', 'sedum', 'd0cf8e6e-b8ec-49b1-8f60-0c9ac28d4cbd'),
('Sempervivum', 'Plantes grasses résistantes au froid.', 'sempervivum', 'd0cf8e6e-b8ec-49b1-8f60-0c9ac28d4cbd'),

-- Cactus
('Cactus globuleux', 'Cactus en forme de boule, souvent en pot.', 'cactus-globuleux', '6a40d6ed-7aa3-46d4-ae42-b5f568791343'),
('Cactus colonnaires', 'Cactus en forme de colonne.', 'cactus-colonnaires', '6a40d6ed-7aa3-46d4-ae42-b5f568791343'),
('Cactus florifères', 'Cactus qui produisent des fleurs.', 'cactus-floriferes', '6a40d6ed-7aa3-46d4-ae42-b5f568791343'),

-- Fougères
('Fougère de Boston', 'Fougère dense avec frondes arquées.', 'fougere-boston', '0aa16bed-c4a4-43d9-a84a-a45a34c3f422'),
('Fougère nid d''oiseau', 'Fougère graphique à grandes frondes.', 'fougere-nid-oiseau', '0aa16bed-c4a4-43d9-a84a-a45a34c3f422'),
('Fougère arborescente', 'Grande fougère appréciée en extérieur.', 'fougere-arborescente', '0aa16bed-c4a4-43d9-a84a-a45a34c3f422'),

-- Orchidées
('Phalaenopsis', 'Orchidée papillon, facile à fleurir.', 'phalaenopsis', '7a6dce61-0d2d-4eac-9878-214d68913dd3'),
('Cattleya', 'Orchidée parfumée.', 'cattleya', '7a6dce61-0d2d-4eac-9878-214d68913dd3'),
('Dendrobium', 'Orchidée grimpante ou épiphyte.', 'dendrobium', '7a6dce61-0d2d-4eac-9878-214d68913dd3'),

-- Plantes à fleurs
('Rosiers', 'Plantes à fleurs classiques de jardin.', 'rosiers', 'dc2fd599-d655-4897-8549-58169034f42c'),
('Hibiscus', 'Fleurs tropicales ou de jardin.', 'hibiscus', 'dc2fd599-d655-4897-8549-58169034f42c'),
('Géraniums', 'Plantes à fleurs colorées pour balcon.', 'geraniums', 'dc2fd599-d655-4897-8549-58169034f42c'),

-- Plantes aromatiques
('Basilic', 'Herbe culinaire parfumée.', 'basilic', 'ea1d8a50-f654-48bb-a70d-19cf3e61f3e1'),
('Thym', 'Plante aromatique résistante.', 'thym', 'ea1d8a50-f654-48bb-a70d-19cf3e61f3e1'),
('Menthe', 'Plante aromatique rafraîchissante.', 'menthe', 'ea1d8a50-f654-48bb-a70d-19cf3e61f3e1'),

-- Plantes médicinales
('Camomille', 'Herbe médicinale relaxante.', 'camomille', '9f34969c-f923-49e5-ab1e-941d47311c03'),
('Aloe vera', 'Plante apaisante pour la peau.', 'aloe-vera', '9f34969c-f923-49e5-ab1e-941d47311c03'),
('Lavande', 'Plante médicinale et aromatique.', 'lavande', '9f34969c-f923-49e5-ab1e-941d47311c03'),

-- Plantes carnivores
('Dionée', 'Venus flytrap, capture d''insectes.', 'dionee', '5f50f744-f03c-4a8a-8211-017645f26e1e'),
('Nepenthes', 'Plantes carnivores tropicales.', 'nepenthes', '5f50f744-f03c-4a8a-8211-017645f26e1e'),
('Sarracenia', 'Plantes carnivores trompettes.', 'sarracenia', '5f50f744-f03c-4a8a-8211-017645f26e1e'),

-- Plantes grimpantes
('Lierre', 'Plantes grimpantes classiques.', 'lierre', '3a30d5d5-9be5-4be2-8e5a-72b2a629eab4'),
('Jasmin', 'Plante grimpante parfumée.', 'jasmin', '3a30d5d5-9be5-4be2-8e5a-72b2a629eab4'),
('Glycine', 'Grimpante décorative à fleurs.', 'glycine', '3a30d5d5-9be5-4be2-8e5a-72b2a629eab4'),

-- Plantes aquatiques
('Lys d''eau', 'Plante flottante à fleur.', 'lys-deau', 'ed29e648-7fb2-4fad-bfe0-4083c9564455'),
('Nénuphar', 'Plante aquatique flottante.', 'nenuphar', 'ed29e648-7fb2-4fad-bfe0-4083c9564455'),
('Papyrus', 'Plante aquatique élancée.', 'papyrus', 'ed29e648-7fb2-4fad-bfe0-4083c9564455'),

-- Arbustes
('Bambou', 'Arbuste élancé et rapide.', 'bambou', '653d010d-cd02-453c-ad5e-0f5f056361ce'),
('Hortensia', 'Arbuste à grosses fleurs.', 'hortensia', '653d010d-cd02-453c-ad5e-0f5f056361ce'),
('Forsythia', 'Arbuste printanier à floraison abrupte.', 'forsythia', '653d010d-cd02-453c-ad5e-0f5f056361ce'),

-- Arbres
('Arbres feuillus', 'Arbres à feuilles caduques.', 'arbres-feuillus', '87a0d49f-f4f0-4810-9700-7a8a52c97c8f'),
('Conifères', 'Arbres à aiguilles persistantes.', 'coniferes', '87a0d49f-f4f0-4810-9700-7a8a52c97c8f'),
('Arbres fruitiers', 'Arbres produisant des fruits.', 'arbres-fruitiers', '87a0d49f-f4f0-4810-9700-7a8a52c97c8f'),

-- Bonsaïs
('Bonsaï caduc', 'Bonsaï d''espèces à feuilles caduques.', 'bonsai-caduc', '7e0f9a17-4c2e-49bb-877e-c22efb680198'),
('Bonsaï japonais', 'Bonsaï d''espèces japonaises traditionnelles.', 'bonsai-japonais', '7e0f9a17-4c2e-49bb-877e-c22efb680198'),

-- Plantes tropicales
('Plantes exotiques', 'Espèces tropicales rares ou décoratives.', 'plantes-exotiques', 'fe0a5381-ce36-459c-9539-24bbead03f7a'),
('Fougères tropicales', 'Fougères venant des zones humides.', 'fougeres-tropicales', 'fe0a5381-ce36-459c-9539-24bbead03f7a'),

-- Plantes vivaces
('Vivaces à fleurs', 'Vivaces colorées à floraison longue.', 'vivaces-fleurs', 'f6518f36-d82c-4ee8-9b1c-53b6cf745861'),
('Vivaces rustiques', 'Vivaces résistantes à l''hiver.', 'vivaces-rustiques', 'f6518f36-d82c-4ee8-9b1c-53b6cf745861'),

-- Plantes annuelles
('Fleurs annuelles', 'Plantes qui vivent une saison.', 'fleurs-annuelles', '79bbe6df-7003-4ee8-b628-48ee844c4cef'),
('Légumes annuels', 'Légumes à cycle annuel.', 'legumes-annuelles', '79bbe6df-7003-4ee8-b628-48ee844c4cef'),

-- Bulbes
('Tulipes', 'Fleurs de printemps en bulbes.', 'tulipes', '67fb39fa-db38-4917-a30d-94c117f0319b'),
('Jacinthes', 'Bulbes parfumés pour le printemps.', 'jacinthes', '67fb39fa-db38-4917-a30d-94c117f0319b'),

-- Plantes couvre-sol
('Sedum couvre-sol', 'Sedum utilisés comme couvre-sol.', 'sedum-couvre-sol', '5e6bd164-350c-42dc-8f6e-1acc3958ff7b'),
('Lierre couvre-sol', 'Lierre rampant pour sol ou bordures.', 'lierre-couvre-sol', '5e6bd164-350c-42dc-8f6e-1acc3958ff7b'),

-- Herbes ornementales
('Carex', 'Graminées décoratives de jardin.', 'carex', '1d20bcff-f33a-458f-8cf1-dff4ec1828d9'),
('Miscanthus', 'Grande herbe ornementale.', 'miscanthus', '1d20bcff-f33a-458f-8cf1-dff4ec1828d9'),

-- Plantes alpines
('Saxifrages', 'Plantes de rocaille et haute montagne.', 'saxifrages', '684822b9-7095-41c8-80f4-0d72c275195d'),
('Edelweiss', 'Plante emblématique des Alpes.', 'edelweiss', '684822b9-7095-41c8-80f4-0d72c275195d'),

-- Plantes de haies
('Laurier', 'Haie persistante et décorative.', 'laurier', '4eca59c1-e0a7-468b-ba6a-2705b582c93d'),
('Photinia', 'Haie rougeoyante.', 'photinia', '4eca59c1-e0a7-468b-ba6a-2705b582c93d'),

-- Plantes fruitières
('Agrumes', 'Citronniers, orangers, etc.', 'agrumes', '4964b9b8-f858-45c3-91ca-0455a40ab94b'),
('Rosiers fruitiers', 'Rosiers produisant des fruits.', 'rosiers-fruitiers', '4964b9b8-f858-45c3-91ca-0455a40ab94b'),

-- Lianes
('Jasmin grimpant', 'Liane parfumée pour treillage.', 'jasmin-grimpant', '82c5dfe7-c830-40bb-b8db-6c67e3472ad0'),
('Vigne', 'Vigne ornementale ou fruitière.', 'vigne', '82c5dfe7-c830-40bb-b8db-6c67e3472ad0'),

-- Fleurs sauvages
('Coquelicots', 'Fleur sauvage commune rouge vif.', 'coquelicots', '5fbd6a7c-5fca-4d6b-b8d9-b34d80cf306e'),
('Pâquerettes', 'Petites fleurs sauvages blanches.', 'paquerettes', '5fbd6a7c-5fca-4d6b-b8d9-b34d80cf306e');