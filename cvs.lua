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

local cvs = {}

function cvs.run()

	customer = require "customer"
	document = require "document"
	position = require "position"
	feedback = require "feedback"
	saldo = require "saldo"
	init = nil

	repeat

		print("\n Выберите действие: \n")
		print(":  0 : Выход из программы")
		print(":  1 : Добавить клиента")
		print(":  2 : Добавить позицию")
		print(":  3 : Добавить документ")
		print(":  4 : Добавить телефон клиента \n")
		print(":  5 : Изменить наименование клиента")
		print(":  6 : Изменить наименование позиции")
		print(":  7 : Изменить стоимость позиции")
		print(":  8 : Изменить выплату в документе")
		print(":  9 : Изменить телефон клиента \n")
		print(": 10 : Удалить клиента")
		print(": 11 : Удалить позицию")
		print(": 12 : Удалить документ")
		print(": 13 : Удалить телефон клиента \n")
		print(": 14 : Показать список клиентов")
		print(": 15 : Показать список позиций \n")
		print(": 16 : Показать баланс по клиенту")
		print(": 17 : Показать общий баланс \n")

		init = tonumber( io.stdin:read() )		

		if init == 1 then
			customer.add()

		elseif init == 2 then
			position.add()

		elseif init == 3 then
			document.add()


		elseif init == 4 then
			feedback.add()

		elseif init == 5 then
			customer.change()

		elseif init == 6 then
			position.change_nominal()

		elseif init == 7 then
			position.change_price()

		elseif init == 8 then
			document.change()

		elseif init == 9 then
			feedback.change()

		elseif init == 10 then
			customer.drop()
		
		elseif init == 11 then
			position.drop()

		elseif init == 12 then
			document.drop()

		elseif init == 13 then
			feedback.drop()

		elseif init == 14 then
			customer.show()

		elseif init == 15 then
			position.show()

		elseif init == 16 then
			saldo.customer()

		elseif init == 17 then
			saldo.common()

		elseif init == 0 then
			print("\n Завершение программы. \n")
		else
			print("\n Команда не корректна. \n")
		end

	until init == 0

	customer = nil
	document = nil
	position = nil
	feedback = nil
	saldo = nil
	init = nil

end

cvs.run()

return cvs