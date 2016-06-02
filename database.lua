--[[
    This file is part of CVS.

    Foobar is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Foobar is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Foobar.  If not, see <http://www.gnu.org/licenses/>.

    Author - Hantenellotf

  (Этот файл — часть CVS.

   CVS - свободная программа: вы можете перераспространять ее и/или
   изменять ее на условиях Стандартной общественной лицензии GNU в том виде,
   в каком она была опубликована Фондом свободного программного обеспечения;
   либо версии 3 лицензии, либо (по вашему выбору) любой более поздней
   версии.

   Foobar распространяется в надежде, что она будет полезной,
   но БЕЗО ВСЯКИХ ГАРАНТИЙ; даже без неявной гарантии ТОВАРНОГО ВИДА
   или ПРИГОДНОСТИ ДЛЯ ОПРЕДЕЛЕННЫХ ЦЕЛЕЙ. Подробнее см. в Стандартной
   общественной лицензии GNU.

   Вы должны были получить копию Стандартной общественной лицензии GNU
   вместе с этой программой. Если это не так, см.
   <http://www.gnu.org/licenses/>.)

   Автор - Hantenellotf

--]]

local database = {}

function database.link()

	driver = require "luasql.sqlite3"
	env = driver.sqlite3()
	db = env:connect("standart.sqlite3")
	return db

end




function database.select_from_where(select, from, where)

	text = "SELECT " .. select .. " FROM " .. from

	if where ~= nil then 
		text = text .. " WHERE " .. where .. " ;"
	else
		text = text .. " ;"
	end

	query = database.link()
	thread = query:execute(text)
	result = thread:fetch({}, "a")	
	return result

end




function database.update_set_where(update, set, where)

	text = "UPDATE " .. update .. " SET " .. set .. " WHERE " .. where .. " ;"
	query = database.link()
	thread = query:execute(text)	

end




function database.delete_from_where(from, where)

	text = "DELETE FROM " .. from .. " WHERE " .. where .. " ;"
	query = database.link()
	thread = query:execute(text)	

end




function database.insert_into_values(table, fields, values)

	text = "INSERT INTO " .. table .. " ( " .. fields .. " ) VALUES ( " .. values .. ") ;"
	query = database.link()
	thread = query:execute(text)

end

return database