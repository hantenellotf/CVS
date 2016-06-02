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

local feedback = {}

function feedback.change()

	base = require "database"

	print("\n Выберите номер телефона для изменения. \n")

	data = base.select_from_where("feedback.number, feedback.phone, customer.name", "feedback, customer", "feedback.customer = customer.number")
	while data do
		print("| № " .. data.number .. " | " .. data.name .. " | " .. data.phone .. " |" )
		data = thread:fetch(data, "a")
	end

	print("\n Укажите клиента для изменения телефона: \n")
	number = io.stdin:read()

	print("\n Введите новый телефон: \n")
	phone = io.stdin:read()

	base.update_set_where( "feedback", "phone = " .. tostring(phone), "number = " .. tostring(number) )

	print("\n Данные клиента изменены. \n")	

end




function feedback.add()

	base = require "database"

	print("\n Список клиентов для добавления телефона: \n")

	data = base.select_from_where( "number, name", "customer", nil )
	while data do
		print("| № " .. data.number .. " | " .. data.name .. " | ")
		data = thread:fetch(data, "a")
	end

	print("\n Укажите номер клиента для добавления телефона: \n")
	number = io.stdin:read()
	print("\n Укажите новый номер телефона: \n")
	phone = io.stdin:read()

	base.insert_into_values( "feedback", "customer, phone", tostring(number) .. ", " .. tostring(phone) )

	print("\n Телефон добавлен. \n")		

end





function feedback.drop()

	base = require "database"

	print("\n Выберите номер телефона для удаления: \n")

	data = base.select_from_where( "feedback.number, customer.name, feedback.phone", "feedback, customer", "feedback.customer = customer.number" )
	while data do
		print("| № " .. data.number .. " | " .. data.name .. " | " .. data.phone .. " |" )
		data = thread:fetch(data, "a")
	end

	print("\n Укажите номер телефона для удаления: \n")
	number = io.stdin:read()

	base.delete_from_where( "feedback", "number = " .. tostring(number) )

	print("\n Телефон удалён. \n")		

end

return feedback