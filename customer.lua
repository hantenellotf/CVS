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

local customer = {}


function customer.add()

	base = require "database"

	print("\n Введите ФИО нового клиента. \n")
	name = io.stdin:read()
	print("Введите номер телефона клиента. \n")
	phone = io.stdin:read()

	base.insert_into_values("customer", "name, phone", "'" .. tostring(name) .."'" )
	data = base.select_from_where("number", "customer", "name = '" .. tostring(name) .. "'")
	while data do
		number = data.number
		data = thread:fetch(data, "a")	
	end
	
	base.insert_into_values("feedback", "customer, phone", "" .. tostring(number) .. ", " .. tostring(phone) )

	print("\n Клиент добавлен. \n")

end



function customer.drop()

	base = require "database"

	print("\n Будьте внимательны: при удалении клиента будут удалены связаные с ним личные данные и документы! \n")

	data = base.select_from_where( "number, name", "customer", nil )
	while data do
		print("| № " .. data.number .. " | " .. data.name .. " | ")
		data = thread:fetch(data, "a")
	end

	print("\n Выберите номер клиента:")
	number = io.stdin:read()

	base.delete_from_where("customer", "customer.number = " .. tostring(number) )
	base.delete_from_where("feedback", "feedback.customer = " .. tostring(number) )
	base.delete_from_where("document", "document.customer = " .. tostring(number) )
	
	print("\n Клиент удалён. \n")

end




function customer.change()

	base = require "database"

	print("\n Список клиентов для изменения: \n")

	data = base.select_from_where( "number, name", "customer", nil )
	while data do
		print("| № " .. data.number .. " | " .. data.name .. " | " )
		data = thread:fetch(data, "a")
	end

	print("\n Укажите клиента для изменения имени: \n")
	number = io.stdin:read()
	print("\n Введите новое наименование клиента: \n")
	name = io.stdin:read()

	base.update_set_where( "customer", "name = '" .. tostring(name) .."'", "number = " .. tostring(number) )

	print("\n Данные клиента изменены. \n")	

end




function customer.show()

	base = require "database"

	print("\n Список клиентов: \n")

	data = base.select_from_where( "customer.number, customer.name, feedback.phone", "customer, feedback", "feedback.customer = customer.number" )
	while data do
		print("| № " .. data.number .. " | " .. data.name .. " | " .. data.phone .. " | ")
		data = thread:fetch(data, "a")
	end

	print("\n Запрос выполнен. \n")	

end


return customer