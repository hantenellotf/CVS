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

local document = {}

function document.add()

	base = require "database"

	print("\n Текущий список клиентов: \n")

	data = base.select_from_where( "number, name", "customer", nil )
	while data do
		print("| № " .. tostring(data.number) .. " | " .. tostring(data.name) .. " | " )
		data = thread:fetch(data, "a")
	end

	print("\n Введите номер нужного Вам клиента: \n")
	customer = io.stdin:read()

	data = base.select_from_where( "number, nominal, price", "position", nil )
	while data do
		print("| № " .. data.number .. " | " .. data.nominal .. " | " .. data.price .. " руб. |" )
		data = thread:fetch(data, "a")
	end

	print("\n Выберите номер услуги из списка.")
	position = io.stdin:read()
	print("\n Укажите внесённую клиентом сумму.")
	price = io.stdin:read()

	base.insert_into_values( "document", "customer, position, income", tostring(customer) .. ', ' .. tostring(position) .. ', ' .. tostring(price) )
	data = base.select_from_where( "document.number, customer.name, position.nominal, document.income, position.price", "document, customer, position", "document.customer = customer.number AND document.position = position.number" )
	while data do
		print("\n | № " .. data.number .. " | " .. data.name .. " | " .. data.nominal .. " | " .. data.income .. " руб. | " .. data.price .. " руб. |" )
		data = thread:fetch(data, "a")
	end

	print("\n Запись добавленна. \n")

end


function document.change()

	print("\n Список текущих документов: \n")

	base = require "database"

	data = base.select_from_where("document.number, customer.name, position.nominal, document.income, position.price", "document, customer, position", "document.customer = customer.number AND document.position = position.number")
	while data do
		print("\n | № " .. data.number .. " | " .. data.name .. " | " .. data.nominal .. " | " .. data.income .. " руб. | " .. data.price .. " руб. |" )
		data = thread:fetch(data, "a")
	end	

	print("\n Укажите номер редактируемой записи \n")
	doc = io.stdin:read()
	print("\n Укажите значение выплаты \n")
	income = io.stdin:read()

	base.update_set_where("document", "income = " .. tostring(income), "number = " .. tostring(doc))
	
	print("\n Выплата зафиксированна. \n")

end


function document.drop()

	print("\n Список текущих документов: \n")

	base = require "database"

	data = base.select_from_where( "document.number, customer.name, position.nominal, document.income, position.price", "document, customer, position", "document.customer = customer.number AND document.position = position.number" )
	while data do
		print("\n | № " .. data.number .. " | " .. data.name .. " | " .. data.nominal .. " | " .. data.income .. " руб. | " .. data.price .. " руб. |" )
		data = thread:fetch(data, "a")
	end	

	print("\n Укажите номер удаляемой записи \n")
	doc = io.stdin:read()

	base.delete_from_where("document", "number = " .. tostring(doc))
	
	print("\n Запись удалена. \n")
	

end


return document