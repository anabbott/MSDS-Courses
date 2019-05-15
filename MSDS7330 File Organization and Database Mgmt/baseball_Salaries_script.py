import lxml.etree as ET
with open("C:/Users/Abbott/Downloads/baseball_salaries_2003_2_2_2.txt") as myfile:
    lines=myfile.readlines()[3:] 
    root = ET.Element("League")
    for l in lines:
        elems = l.split(":")
        if len(elems) == 4:
            elems = [x.strip() for x in elems]
            team = ET.SubElement(root, "Team")
            player = ET.SubElement(team, "Player")
            salary = ET.SubElement(player, "Salary")
            position = ET.SubElement(player, "Position")
            team.text = elems[0]
            player.text = elems[1]
            salary.text = elems[2]
            position.text = elems[3]
    
    tree = ET.ElementTree(root)
    tree.write("salaries.xml", pretty_print=True)
    print(ET.tostring(tree, pretty_print=True))
