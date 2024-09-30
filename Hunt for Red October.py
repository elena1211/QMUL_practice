### the scrambled message to Red October
scrambled="QNTSINUAYGTOTPENAOGCSYDBBLTHRYTOYSWPMWTBESRNAEETBHTNTBGOAPTMNETHMIROCYCGULAYEGEWA"
scrambled_list = list(scrambled)
scrambled_list.reverse()
list1 = scrambled_list[1::3]
sentence1 = ''.join(list1)
print(sentence1)
