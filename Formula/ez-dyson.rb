class EzDyson < Formula
  homepage "http://iopenshell.usc.edu/downloads/ezdyson/"
  url "http://iopenshell.usc.edu/downloads/ezdyson/ezdyson.v3.tar.gz"
  version "3.1"
  sha256 "83eadb845d755c57469d21700d4cd3842c892e5a115bf8df256681c54aab96ca"

  fails_with :clang do
    cause "Requires OpenMP"
  end

  fails_with :gcc do
    build 5666
  end

  def install
    system "make", "-f", "mk.Mac", "CCFLAGS=-O3 -fopenmp -lexpat"
    bin.install "exedys"
  end

  test do
    File.open("test_input.xml", "w") {|f| f.write(test_input)}
    system "#{bin}/exedys test_input.xml"
  end

  def test_input; <<-EOF.undent
    <?xml version="1.0" encoding="ISO-8859-1"?>
    <root job="dyson">
      <geometry n_of_atoms="1" text="       F       0.0000000000     0.0000000000     0.0000000000    "/>
      <free_electron charge_of_ionized_core="0" l_max="5">
        <k_grid max="1.1" min="0.1" n_points="11"/>
      </free_electron>
      <averaging method="avg" method_possible_values="noavg, avg"/>
      <laser ionization_energy="1.0">
        <laser_polarization x="0.0" y="0.0" z="1.0"/>
      </laser>
      <lab_xyz_grid>
        <axis max="10.0" min="-10.0" n_points="201"/>
      </lab_xyz_grid>
      <job_parameters Dyson_MO_transitions="1" MOs_to_plot="" number_of_MOs_to_plot="0" orbital_degeneracy="1" spin_degeneracy="1" unrestricted="false"/>
      <basis AO_ordering="Q-Chem" n_of_basis_functions="46" purecart="                  111           (5D)">
        <atom text=" F    0 S    8    1.000000    1.95000000E+04    5.07000000E-04     2.92300000E+03    3.92300000E-03     6.64500000E+02    2.02000000E-02     1.87500000E+02    7.90100000E-02     6.06200000E+01    2.30439000E-01     2.14200000E+01    4.32872000E-01     7.95000000E+00    3.49964000E-01     8.81500000E-01   -7.89200000E-03  S    8    1.000000    1.95000000E+04   -1.17000000E-04     2.92300000E+03   -9.12000000E-04     6.64500000E+02   -4.71700000E-03     1.87500000E+02   -1.90860000E-02     6.06200000E+01   -5.96550000E-02     2.14200000E+01   -1.40010000E-01     7.95000000E+00   -1.76782000E-01     8.81500000E-01    6.05043000E-01  S    1    1.000000    2.25700000E+00    1.00000000E+00  S    1    1.000000    3.04100000E-01    1.00000000E+00  P    3    1.000000    4.38800000E+01    1.66650000E-02     9.92600000E+00    1.04472000E-01     2.93000000E+00    3.17260000E-01  P    1    1.000000    9.13200000E-01    1.00000000E+00  P    1    1.000000    2.67200000E-01    1.00000000E+00  D    1    1.000000    3.10700000E+00    1.00000000E+00  D    1    1.000000    8.55000000E-01    1.00000000E+00  F    1    1.000000    1.91700000E+00    1.00000000E+00  S    1    1.000000    9.15800000E-02    1.00000000E+00  P    1    1.000000    7.36100000E-02    1.00000000E+00  D    1    1.000000    2.92000000E-01    1.00000000E+00  F    1    1.000000    7.24000000E-01    1.00000000E+00  ****        "/>
      </basis>
      <!-- DMOs and MOs BELOW ARE FROM THE "fanion.in.out" Q-CHEM OUTPUT -->
      <dyson_molecular_orbitals>
        <DMO comment="dyson right" norm="0.9552" text="     1.8389841203780251e-17     1.1903870632800483e-16     5.4987535044781681e-17    -1.5574336829778329e-16    -3.4725893694240551e-01    -1.1072953202743876e-08    -2.0069351232897015e-08    -4.1848201438940719e-01    -1.3675225039450919e-08    -2.4445524859891926e-08    -3.7264935760279505e-01    -6.3584210169604930e-09    -1.7199533810850822e-08    -1.2689155940515461e-17    -7.0236576288534791e-18     5.7261545325657692e-18    -1.4351145828452825e-17    -8.7238410184173782e-18     3.0737207870575094e-18     2.5354508022545861e-18    -3.3789613130764378e-17    -6.0238149633142449e-17    -3.1918428593079168e-17    -7.6293711994875383e-11     1.7883424268433195e-13     1.9775570832306034e-11     3.7822690166856347e-11    -9.5838708955894798e-09    -4.8925043659564437e-11     1.2370444343233804e-08     1.1654700548901647e-16    -1.7073664059361460e-01    -2.1229274467276531e-08    -2.2256447424720347e-08    -1.0951990004811802e-17     1.2081169937197812e-18     4.4633060350141572e-17    -2.8556045095064949e-17     1.2143069802525954e-16    -1.1038829275714609e-10    -2.8233654063108724e-12     2.8469500149066175e-11     5.4825955485429738e-11     1.6710697571579000e-08    -7.0730162238736837e-11    -2.1561961248174379e-08     " transition="[ Reference -- EOM-IP-CCSD state  1/A   ]"/>
        <DMO comment="dyson left" norm="0.9425" text="     2.4682617795958195e-17     1.3143015164407154e-16     5.6422623906431533e-17    -2.0140782799679492e-16    -3.5272564310847571e-01     1.6980976290337600e-08     1.7679003942591817e-09    -4.2722221040093727e-01     1.9169729285618946e-08     1.0444301337200997e-09    -3.7148271554780704e-01     1.8027830795571328e-08     1.9767985402093997e-09    -1.3500729937248896e-17    -7.2302437455316223e-18     5.5077762084671656e-18    -1.4459692218722389e-17    -9.3578247844531898e-18     4.5308114671789031e-18     4.0085168951576687e-18    -3.4225476650166006e-17    -6.1943844218014658e-17    -3.1563002665080907e-17    -8.0540108542502629e-11     7.6935774355897439e-14     2.1487136495407638e-11     3.9636885123541599e-11     8.4034128583329556e-09    -5.2030447478428645e-11    -1.0850885546488630e-08     1.7883252925601747e-16    -1.4892610615247145e-01    -1.0272755039256270e-08    -1.2943097832097285e-08    -2.1455039502176483e-17     9.1499730013791021e-20     4.3770003223827718e-17    -2.3429802054628476e-17     1.1780200687817457e-16    -1.0856838902290863e-10    -2.7686232390476539e-12     2.7979687224055808e-11     5.3930992139796657e-11     6.8727712153462472e-09    -6.9550006305474438e-11    -8.8614635315760760e-09     " transition="[ Reference -- EOM-IP-CCSD state  1/A   ]"/>
      </dyson_molecular_orbitals>
      <molecular_orbitals total_number="1">
        <alpha_MOs>
          <MO number="1" text="   1.00000     " type="alpha"/>
        </alpha_MOs>
        <beta_MOs>
          <MO number="1" text="   1.00000     " type="beta"/>
        </beta_MOs>
      </molecular_orbitals>
      <!-- Q-CHEM INPUT IS RESTORED FROM THE "fanion.in.out" Q-CHEM OUTPUT -->
      <qchem_input>--------------------------------------------------------------
    $molecule
    -1 1
    F
    $end

    $rem
    jobtype                    SP            single point
    method                     eom-ccsd
    BASIS                      aug-cc-pVTZ
    symmetry                   false
    sym_ignore                 true
    purecart                   111           (5D)
    scf_convergence            7
    MAX_SCF_CYCLES             150
    ip_states                  [1]
    cc_trans_prop              true
    cc_do_dyson                true
    cc_t_conv                  7
    eom_davidson_convergence   6
    print_general_basis        true
    molden_format = 1
    $end



    --------------------------------------------------------------
    </qchem_input>
    </root>
    EOF
  end

end
