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

local saldo = {}


function saldo.common()

	base = require "database"
	price = 0
	income = 0

	data = base.select_from_where( "document.number, customer.name, position.nominal, document.income, position.price", "document, customer, position", "document.customer = customer.number AND document.position = position.number" )
	while data do
		print("\n | № " .. data.number .. " | " .. data.name .. " | " .. data.nominal .. " | " .. data.income .. " руб. | " .. data.price .. " руб. |" )
		price = price + tonumber(data.price)
		income = income + tonumber(data.income)
		data = thread:fetch(data, "a")
	end
	
	balans = income - price
	print('\n Суммарный приход от клиентов: ' .. tostring(income) )
	print('Суммарная стоимость услуг   : ' .. tostring(price)  )
	print('Баланс приход / расход      : ' .. tostring(balans) )

end




function saldo.customer()

	base = require "database"
	price = 0
	income = 0

	data = base.select_from_where( "number, name", "customer", nil )
	while data do
		print("| № " .. data.number .. " | " .. data.name .. " | " )
		data = thread:fetch(data, "a")
	end

	print("\n Выберите клиента для расчёта баланса: \n")
	number = io.stdin:read()

	data = base.select_from_where( "document.number, customer.name, position.nominal, document.income, position.price", "document, customer, position", "document.customer = customer.number AND document.position = position.number AND document.customer = " .. tostring(number) )
	while data do
		print("\n | № " .. data.number .. " | " .. data.name .. " | " .. data.nominal .. " | " .. data.income .. " руб. | " .. data.price .. " руб. |" )
		
		price = price + tonumber(data.price)
		income = income + tonumber(data.income)
		data = thread:fetch(data, "a")
	end
	
	balans = income - price
	print('\n Суммарный приход от клиента: ' .. tostring(income) )
	print('Суммарная стоимость услуг  : ' .. tostring(price)  )
	print('Баланс приход / расход     : ' .. tostring(balans) )

end


return saldo