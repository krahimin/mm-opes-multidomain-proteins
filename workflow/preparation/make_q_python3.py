#!/usr/bin/env python3

import sys
import math

def read_xyz(pdb_line: str):
    X = float(pdb_line[30:38])
    Y = float(pdb_line[38:46])
    Z = float(pdb_line[46:54])
    return X, Y, Z

def main():
    if len(sys.argv) != 3:
        print("Usage: ./make_qlist_protein_py3.py structurefile.pdb outfilename.dat")
        sys.exit(0)

    aa_pdblines = open(sys.argv[1], "r").readlines()
    outfile = open(sys.argv[2], "w")

    # interactive inputs
    fudge = float(input("Fudge Factor:  "))
    cutoff = float(input("Cutoff (Angstroms):  "))
    excl = float(input("Minimum number of bonds between atoms to be counted: "))

    listtype = input(
        "Please respond with one of the letter options below\n"
        "(Note that trplists are only useful when more than one TRP is present):\n"
        "\tAll-Atom (aa)\n"
        "\tBackbone (bb)\n"
        "\tSide-Chain (sc)\n"
        "\tNative Hydrogen Bond (hb)\n"
        "\tNon-native Hydrogen Bond (nn)\n"
        "\tTryptophan residues, native (trp)\n"
        "\tTryptophan residues, nonnative (trpnn)\n"
        "\tTurn List (Hydrogen Bonds) (tlh)\n"
        "\tTurn list (all atom) (tla) :"
    ).strip()

    # Turn List details
    turnstart = None
    if listtype in ["tla", "tlh"]:
        peplength = int(input(
            "How many residues are in your peptide (turn will be assumed to be 4 residues and symmetric): "
        ))
        turnstart = (peplength // 2) - 1

    # TRP List Details
    trptype = None
    trpres1 = None
    trpres2 = None
    if listtype in ["trp", "trpnn"]:
        trptype = input("Create list for all TRP contacts (all) or residue pairs (pairs)?\n\t:").strip()
        if trptype == "pairs":
            trpres1 = int(input("First TRP residue number: "))
            trpres2 = int(input("Second TRP residue number: "))

    xyz = []
    res = []
    ind = []
    donor_list = []
    acceptor_list = []
    a = []

    # create list of all possible Qlist atoms
    for line in aa_pdblines:
        if line[0:6] != "ATOM  ":
            continue

        atom = line[12:16].strip()
        resid = line[17:20].strip()
        resnum = int(line[22:26].strip())

        if listtype == "aa":
            if atom and atom[0] != "H":
                X, Y, Z = read_xyz(line)
                xyz.append((X, Y, Z))
                ind.append(int(line[6:11]))
                res.append(int(line[22:26]))
                a.append(line[12:16])

        elif listtype == "bb":
            if atom in ["CA", "C", "N", "O"]:
                X, Y, Z = read_xyz(line)
                xyz.append((X, Y, Z))
                ind.append(int(line[6:11]))
                res.append(int(line[22:26]))
                a.append(line[12:16])

        elif listtype == "sc":
            if atom not in ["CA", "C", "N", "O"]:
                X, Y, Z = read_xyz(line)
                xyz.append((X, Y, Z))
                ind.append(int(line[6:11]))
                res.append(int(line[22:26]))
                a.append(line[12:16])

        elif listtype in ["trp", "trpnn"]:
            if resid == "TRP" and atom not in ["CA", "C", "N", "O"]:
                X, Y, Z = read_xyz(line)
                resnum_local = int(line[22:26].strip())

                if trptype == "pairs":
                    if resnum_local in [trpres1, trpres2]:
                        xyz.append((X, Y, Z))
                        ind.append(int(line[6:11]))
                        res.append(int(line[22:26]))
                        a.append(line[12:16])
                elif trptype == "all":
                    xyz.append((X, Y, Z))
                    ind.append(int(line[6:11]))
                    res.append(int(line[22:26]))
                    a.append(line[12:16])

        elif listtype == "tla":
            if turnstart is not None and resnum in range(turnstart, turnstart + 4):
                if atom and atom[0] != "H":
                    X, Y, Z = read_xyz(line)
                    xyz.append((X, Y, Z))
                    ind.append(int(line[6:11]))
                    res.append(int(line[22:26]))
                    a.append(line[12:16])

        elif listtype == "tlh":
            if turnstart is not None and resnum in range(turnstart, turnstart + 4):
                if atom in ["H", "HN"]:
                    X, Y, Z = read_xyz(line)
                    atom_id = int(line[6:11])
                    res_id = int(line[22:26])
                    donor_list.append((atom_id, res_id, X, Y, Z))
                elif atom == "O":
                    X, Y, Z = read_xyz(line)
                    atom_id = int(line[6:11])
                    res_id = int(line[22:26])
                    acceptor_list.append((atom_id, res_id, X, Y, Z))

        elif listtype in ["hb", "nn"]:
            if atom in ["H", "HN"]:
                X, Y, Z = read_xyz(line)
                atom_id = int(line[6:11])
                res_id = int(line[22:26])
                donor_list.append((atom_id, res_id, X, Y, Z))
            elif atom == "O":
                X, Y, Z = read_xyz(line)
                atom_id = int(line[6:11])
                res_id = int(line[22:26])
                acceptor_list.append((atom_id, res_id, X, Y, Z))

    if donor_list:
        print(f"{len(donor_list)} h")
    else:
        print(len(ind))

    # For hydrogen bond lists check donor/acceptor pairs
    if listtype in ["hb", "nn", "tlh"]:
        for ind_don, res_don, X_don, Y_don, Z_don in donor_list:
            for ind_acc, res_acc, X_acc, Y_acc, Z_acc in acceptor_list:
                if abs(res_don - res_acc) > excl:
                    dX = X_don - X_acc
                    dY = Y_don - Y_acc
                    dZ = Z_don - Z_acc
                    r_da = math.sqrt(dX**2 + dY**2 + dZ**2)

                    if listtype in ["hb", "tlh"]:
                        if r_da < cutoff:
                            outfile.write(f"{ind_don:5d} {ind_acc:5d} {cutoff * fudge:8.3f}\n")
                    elif listtype == "nn":
                        if r_da > cutoff * fudge:
                            outfile.write(f"{ind_don:5d} {ind_acc:5d} {cutoff * fudge:8.3f} 1.0\n")

    # For other lists calculate distance between all pairs
    else:
        natom = len(xyz)
        for i in range(natom - 1):
            iX, iY, iZ = xyz[i]
            iind = ind[i]
            ires = res[i]
            ia = a[i]

            print(i)

            for j in range(i + 1, natom):
                jX, jY, jZ = xyz[j]
                jind = ind[j]
                jres = res[j]
                ja = a[j]

                if abs(ires - jres) > excl:
                    dX = iX - jX
                    dY = iY - jY
                    dZ = iZ - jZ
                    rij = math.sqrt(dX**2 + dY**2 + dZ**2)

                    if listtype == "trpnn":
                        if rij > cutoff:
                            outfile.write(f"{iind:5d} {jind:5d} {rij * fudge:8.3f}\n")
                    else:
                        if rij < cutoff:
                            outfile.write(
                                f"{iind:5d} {jind:5d} {rij * fudge:8.3f} {ires:3d} {ia:4s} {jres:3d} {ja:4s} \n"
                            )

    outfile.close()

if __name__ == "__main__":
    main()

