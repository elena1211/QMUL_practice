lanthanides=['La', 'Ce', 'Pr', 'Nd', 'Pm', 'Sm', 'Eu', 'Gd', 'Tb', 'Dy', 'Ho', 'Er', 'Tm', 'Yb', 'Lu']
actinides=['Ac', 'Th', 'Pa', 'U', 'Np', 'Pu', 'Am', 'Cm', 'Bk', 'Cf', 'Es', 'Fm', 'Md', 'No', 'Lr']
actinides = [::-1]
symbols = lanthanides[:] 
symbols.extend(actinides) 
symbols.sort()
# Use a comprehension to build a list of all elements of lanthanides ending with the character ’m’.
lanthanides_m = [element for element in lanthanides if element.endswith('m')]
# Use a comprehension to build a list of strings, each including an element of lanthanides followed by ’$’ and by the element of actinides with the same index (example: ’La$Ac’)
combined = [lanthanides[i] + '$' + actinides[i] for i in range (min(len(lanthanides), len(actinides)))]