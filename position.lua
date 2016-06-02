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

local position = {}

function position.add()

	base = require "database"
	
	print("\n Введите наименование операции.")
	nominal = io.stdin:read()
	print("\n Введите стоимость операции.")
	price = io.stdin:read()

	base.insert_into_values( "position", "nominal, price", "'" .. tostring(nominal) .. "'" .. tostring(price) )

	print("\n Наименование добавленно. \n")

end




function position.drop()

	base = require "database"

	print("\n Внимание! После удаления позиции будут удалены все документы с этой позицией. \n")
	
	data = base.select_from_where( "number, nominal, price", "position", nil )
	while data do
		print("| № " .. data.number .. " | " .. data.nominal .. " | " .. data.price .. " руб. |" )
		data = thread:fetch(data, "a")
	end	

	print("\n Укажите номер удаляемой позиции \n")
	number = io.stdin:read()

	base.delete_from_where( "position", "position.number = " .. tostring(number) )
	base.delete_from_where( "document", "document.position = " .. tostring(number) )

	thread = io.stdin:read()
	print("\n Позиция удалена. \n")

end




function position.change_nominal()

	base = require "database"

	data = base.select_from_where( "number, nominal, price", "position", nil )
	while data do
		print("| № " .. data.number .. " | " .. data.nominal .. " | " .. data.price .. " руб. |" )
		data = thread:fetch(data, "a")
	end	
	
	print("\n Укажите номер для изменения наименования позиции: \n")
	number = io.stdin:read()
	print("\n Укажите новое наименование: \n")
	nominal = io.stdin:read()

	base.update_set_where( "position", "nominal = " .. tostring(nominal), "number = " .. tostring(number) )

	print("\n Наименование изменено. \n")

end




function position.change_price()

	base = require "database"

	data = base.select_from_where( "number, nominal, price", "position", nil )
	while data do
		print("| № " .. data.number .. " | " .. data.nominal .. " | " .. data.price .. " руб. |" )
		data = thread:fetch(data, "a")
	end	
	
	print("\n Укажите номер для изменения цены: \n")
	number = io.stdin:read()
	print("\n Укажите новую цену: \n")
	price = io.stdin:read()

	base.update_set_where( "position", "price = " .. tostring(price), "number = " .. tostring(number) )

	print("\n Телефон изменён. \n")

end




function position.show()

	base = require "database"

	print("Список позиций: \n")

	data = base.select_from_where( "number, nominal, price", "position", nil )
	while data do
		print("| № " .. data.number .. " | " .. data.nominal .. " | " .. data.price .. " руб. |" )
		data = thread:fetch(data, "a")
	end

	print("\n Запрос выполнен. \n")		

end


return position