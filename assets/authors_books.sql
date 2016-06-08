DROP TABLE `authors_books`;

CREATE TABLE `authors_books` (
  `id` mediumint(8) unsigned NOT NULL auto_increment,
  `author_id` mediumint default NULL,
  `book_id` mediumint default NULL,
  PRIMARY KEY (`id`)
) AUTO_INCREMENT=1;

ALTER TABLE authors_books ADD CONSTRAINT fk_author FOREIGN KEY (author_id) REFERENCES authors(id);
ALTER TABLE authors_books ADD CONSTRAINT fk_book FOREIGN KEY (book_id) REFERENCES books(id);

INSERT INTO `authors_books` (`author_id`,`book_id`) VALUES (8,21),(16,2),(3,1),(11,25),(5,46),(3,5),(11,32),(14,43),(5,17),(8,19);
INSERT INTO `authors_books` (`author_id`,`book_id`) VALUES (15,34),(9,14),(4,44),(13,50),(19,24),(2,20),(1,23),(4,44),(17,21),(2,15);
INSERT INTO `authors_books` (`author_id`,`book_id`) VALUES (15,3),(14,22),(14,44),(10,50),(10,24),(13,47),(19,38),(6,48),(15,5),(6,46);
INSERT INTO `authors_books` (`author_id`,`book_id`) VALUES (17,27),(16,21),(5,37),(2,32),(12,34),(18,28),(17,42),(3,5),(10,24),(1,2);
INSERT INTO `authors_books` (`author_id`,`book_id`) VALUES (10,24),(6,17),(19,44),(15,9),(18,32),(1,44),(8,27),(2,7),(4,50),(4,14);
INSERT INTO `authors_books` (`author_id`,`book_id`) VALUES (10,10),(17,13),(16,33),(1,17),(20,27),(10,19),(6,12),(9,7),(20,47),(16,40);
INSERT INTO `authors_books` (`author_id`,`book_id`) VALUES (7,24),(11,22),(13,17),(1,37),(11,39),(19,19),(11,33),(6,20),(16,3),(9,12);
INSERT INTO `authors_books` (`author_id`,`book_id`) VALUES (3,33),(18,14),(2,8),(13,19),(2,30),(19,20),(8,42),(20,42),(2,13),(6,41);
INSERT INTO `authors_books` (`author_id`,`book_id`) VALUES (11,35),(6,18),(17,19),(5,47),(18,8),(10,8),(15,12),(17,9),(9,38),(3,12);
INSERT INTO `authors_books` (`author_id`,`book_id`) VALUES (15,36),(5,15),(6,26),(13,25),(7,47),(19,9),(4,40),(18,25),(13,48),(2,24);
