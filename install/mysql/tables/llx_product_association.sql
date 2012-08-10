-- ============================================================================
-- Copyright (C) 2006 Rodolphe Quiedeville <rodolphe@quiedeville.org>
-- Copyright (C) 2010 Laurent Destailleur  <eldy@users.sourceforge.net>
--
-- This program is free software; you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation; either version 2 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program. If not, see <http://www.gnu.org/licenses/>.
--
-- $Id: llx_product_association.sql,v 1.3 2011/08/03 01:25:26 eldy Exp $
-- ============================================================================

create table llx_product_association
(
  rowid                 integer AUTO_INCREMENT PRIMARY KEY,
  fk_product_pere       integer NOT NULL DEFAULT 0, -- id du produit maitre
  fk_product_fils       integer NOT NULL DEFAULT 0, -- id du sous-produit
  qty                   double NULL
)ENGINE=innodb;

