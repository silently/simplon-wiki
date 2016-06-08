DROP TABLE `authors`;

CREATE TABLE `authors` (
  `id` mediumint(8) unsigned NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `town` varchar(255),
  `company` varchar(255),
  PRIMARY KEY (`id`)
) AUTO_INCREMENT=1;

INSERT INTO `authors` (`name`,`town`,`company`) VALUES ("Dora Jimenez","Namur","Ut Ipsum Ac Institute"),("Isabella Cooper","Foligno","Nunc Ullamcorper Velit Institute"),("Molly Berg","Carahue","Turpis Egestas Associates"),("Abel Day","Macduff","Facilisis Ltd"),("Dai Beard","Stornaway","Morbi Sit LLC"),("Carissa Buck","Penna San Giovanni","Cursus Consulting"),("Justina Hull","Empoli","Eget Corp."),("Avram Buckley","Serrungarina","Sed Est Nunc Corporation"),("Adria Banks","Lanco","Pellentesque Industries"),("Cara Bolton","Hard","Egestas Institute");
INSERT INTO `authors` (`name`,`town`,`company`) VALUES ("Shelley Ayers","Saskatoon","Aenean Euismod Mauris LLC"),("Hoyt Ruiz","Codognè","Vulputate Lacus Cras Incorporated"),("Karyn Ellison","Udaipur","Non Justo Proin Consulting"),("Ralph Petty","Trivigno","Nibh Dolor Nonummy Corp."),("Jason Sampson","Knoxville","Scelerisque Dui Suspendisse Industries"),("Iliana Pitts","Lalbahadur Nagar","Mi Fringilla Mi Corp."),("Quinn Cooke","Trivandrum","Tristique Pellentesque Corporation"),("Lara Dixon","Meise","Tristique Incorporated"),("Ella Mcknight","Brandenburg","Amet Orci PC"),("Charissa Jacobs","Güssing","Duis Dignissim Inc.");
