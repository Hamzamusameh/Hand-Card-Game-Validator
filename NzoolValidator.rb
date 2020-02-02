require 'set'

def getCardNumber(card)
    values = ['','','2' ,'3' ,'4' ,'5' ,'6' ,'7' ,'8' ,'9' ,'10' ,'J' ,'Q' ,'K' ,'A']
    return values.index((card.length == 2 ? card[0] : card[0..1]))
end

def valid_group(nzool)
        cardsNotations = Set.new
        cardsNumbers = Set.new
        numberOfJoker = 0

        if nzool.length < 3
            return "Invald"
        else
            # counting number of joker
            for i in 0 .. nzool.length - 1
              if nzool[i][1] == 'j'
                numberOfJoker += 1
              elsif nzool[i].length == 2
                cardsNotations.add(nzool[i][1])
                cardsNumbers.add(nzool[i][0])
              else # for 10 card getCardNumber
                cardsNotations.add(nzool[i][2])
                cardsNumbers.add(nzool[i][0..1])
              end
            end

            # Check # of joker 
            if numberOfJoker > 1
              return "invalid"
            else
              if cardsNotations.length == 1 && cardsNumbers.length != 1
                reversedNzool = nzool
                reversedNzool.delete('1j')
                reversedNzool.delete('2j')
                if getCardNumber(nzool[nzool.length-1]) > getCardNumber(nzool[0])
                  reversedNzool = nzool.reverse()
                end
                for i in 0..reversedNzool.length - 2
                  if reversedNzool[i][1] == 'j' or reversedNzool[i+1][1] == 'j'
                    next
                  elsif (getCardNumber(reversedNzool[i]) - getCardNumber(reversedNzool[i+1])) != 1 
                    if ((getCardNumber(reversedNzool[i]) - getCardNumber(reversedNzool[i+1])) == 12 && reversedNzool[i][0] == 'A') || ((getCardNumber(reversedNzool[i]) - getCardNumber(reversedNzool[i+1])) == -1 && reversedNzool[i][0] == '2')
                      next
                    else
                      return "Invalid"
                    end
                  end
                end
              elsif (cardsNotations.length + numberOfJoker) != nzool.length
                return "invalid"
              else
                if cardsNumbers.length > 1
                  return "Invalid"
                end    
              end
            end
        end
        return "Valid"
end

puts "//////////////// Valid TestCases ////////////////////"
puts valid_group(["Qh", "Kh", "1j"]) # Valid
puts valid_group(["Ac", "2c", "3c"]) # Valid/////////
puts valid_group(["3c", "2c", "Ac"]) # Valid//////////
puts valid_group(["3h", "3c", "3s"]) # Valid
puts valid_group(["Ah", "Ac", "As"]) # Valid
puts valid_group(["4h", "4c", "4s", "4d"]) # Valid
puts valid_group(["3h", "4h", "5h", "6h", "7h"]) # Valid
puts valid_group(["5h", "4h", "3h"]) # Valid
puts valid_group(["Qd", "Kd", "Ad"]) # Valid
puts valid_group(["3h", "1j", "3c"]) # Valid
puts valid_group(["1j", "4h", "4s"]) # Valid
puts valid_group(["2j", "2h", "3h"]) # Valid
puts valid_group(["3h", "1j", "3c"]) # Valid
puts "//////////////// Invalid TestCases ////////////////////"
puts valid_group(["3h", "1j", "3h"]) # Invalid
puts valid_group(["5h", "5d", "5d", "5s"]) # Invalid
puts valid_group(["5h", "5c", "5d", "5s", "5c"]) # Invalid
puts valid_group(["5h", "7h", "6h"]) # Invalid
puts valid_group(["5h", "7h", "8h"]) # Invalid
puts valid_group(["Kh", "Ah", "2h"]) # Invalid
puts valid_group(["1j", "2j", "6h"]) # Invalid
puts valid_group(["2j", "3h", "5h"]) # Invalid
puts valid_group(["2h", "3h"]) # Invalid