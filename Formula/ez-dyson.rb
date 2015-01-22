require 'formula'

class EzDyson < Formula
  homepage "http://iopenshell.usc.edu/downloads/ezdyson/"
  url "http://iopenshell.usc.edu/downloads/ezdyson/ezdyson.v3.tar.gz"
  version "3.0"
  sha1 "1dd325fc2d77dd26cca571a4b0f3080dbf1992ac"

  fails_with :clang do
    cause "Requires OpenMP"
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
      <geometry n_of_atoms="1" text="       F       0.000000     0.000000     0.000000   "/>
      <free_electron l_max="3" radial_functions="spherical" radial_functions_possible_valuse="spherical coulomb coulombzerok">
        <k_grid max="2.01" min="0.01" n_points="11"/>
      </free_electron>
      <averaging method="avg" method_possible_values="noavg, avg"/>
      <laser ionization_energy="3.40">
        <laser_polarization x="0.0" y="0.0" z="1.0"/>
      </laser>
      <lab_xyz_grid comment="Axis order: x, y, z">
        <axis max="6.45" min="-6.45" n_points="173"/>
        <axis max="6.45" min="-6.45" n_points="173"/>
        <axis max="6.45" min="-6.45" n_points="173"/>
      </lab_xyz_grid>
      <job_parameters Dyson_MO_transitions="1" MOs_to_plot="" number_of_MOs_to_plot="0" unrestricted="false"/>
      <basis n_of_basis_functions="46" purecart="                  111           (5D)">
        <atom text=" F    0 S    8    1.000000    1.95000000E+04    5.07000000E-04     2.92300000E+03    3.92300000E-03     6.64500000E+02    2.02000000E-02     1.87500000E+02    7.90100000E-02     6.06200000E+01    2.30439000E-01     2.14200000E+01    4.32872000E-01     7.95000000E+00    3.49964000E-01     8.81500000E-01   -7.89200000E-03  S    8    1.000000    1.95000000E+04   -1.17000000E-04     2.92300000E+03   -9.12000000E-04     6.64500000E+02   -4.71700000E-03     1.87500000E+02   -1.90860000E-02     6.06200000E+01   -5.96550000E-02     2.14200000E+01   -1.40010000E-01     7.95000000E+00   -1.76782000E-01     8.81500000E-01    6.05043000E-01  S    1    1.000000    2.25700000E+00    1.00000000E+00  S    1    1.000000    3.04100000E-01    1.00000000E+00  P    3    1.000000    4.38800000E+01    1.66650000E-02     9.92600000E+00    1.04472000E-01     2.93000000E+00    3.17260000E-01  P    1    1.000000    9.13200000E-01    1.00000000E+00  P    1    1.000000    2.67200000E-01    1.00000000E+00  D    1    1.000000    3.10700000E+00    1.00000000E+00  D    1    1.000000    8.55000000E-01    1.00000000E+00  F    1    1.000000    1.91700000E+00    1.00000000E+00  S    1    1.000000    9.15800000E-02    1.00000000E+00  P    1    1.000000    7.36100000E-02    1.00000000E+00  D    1    1.000000    2.92000000E-01    1.00000000E+00  F    1    1.000000    7.24000000E-01    1.00000000E+00  ****        "/>
      </basis>
      <!-- DMOs and MOs BELOW ARE FROM THE "fanion.in.out" Q-CHEM OUTPUT -->
      <dyson_molecular_orbitals>
        <DMO comment="dyson right alpha" norm="0.9552" text="    -8.3859134429139848e-18     2.8896819542192306e-17    -1.0163967761588343e-17     9.5408414999515783e-17     2.6757869493489317e-01     1.7396436132653745e-01     1.3684593408176982e-01     3.2245929101298976e-01     2.0964458560069724e-01     1.6491314038129615e-01     2.8714317323998534e-01     1.8668406588609285e-01     1.4685166077761549e-01    -8.1976035676930487e-18     1.1829010595395966e-17     8.6136561304980137e-18     2.1530356441524001e-17     1.4152110164530570e-18     3.6657449895976478e-17     3.8087789921323189e-17    -1.8813403537248831e-18     3.7657860947080908e-17     4.4524089228634486e-19    -9.4895419976828079e-09    -9.2283560571173980e-09     1.0728737254208060e-09     6.8628830885800395e-09     1.6526703647652607e-09    -4.0936986216866458e-09     1.5191235038387054e-09    -3.1651212132673339e-18     1.3156029291821020e-01     8.5532976984568659e-02     6.7282976925320870e-02    -1.0063414774318483e-16     9.5408732866145007e-17     5.0046308382441102e-17    -5.5492863984614874e-17    -2.8584695533248235e-16     1.6533887916378391e-08     1.6069606047002574e-08    -1.8766299724370243e-09    -1.1954226118077129e-08    -2.8831894860843713e-09     7.1384031868823956e-09    -2.6449557295922315e-09     " transition="[ Reference -- EOMIP-CCSD state  1/A   ]"/>
        <DMO comment="dyson left alpha" norm="0.9425" text="    -7.3562475222956452e-18     2.9475582228985549e-17    -1.3620248319828843e-17     1.0211519260560096e-16     2.7179103929098303e-01     1.7670298662359352e-01     1.3900022431862749e-01     3.2919400724770231e-01     2.1402311279754688e-01     1.6835742992263483e-01     2.8624422383843667e-01     1.8609962036358701e-01     1.4639191715080097e-01    -8.8998322711540535e-18     1.2233341609554511e-17     7.6305268587740103e-18     2.2237884001743773e-17     1.1740820973934177e-18     3.9991705281752370e-17     3.9928756088537581e-17    -1.0671686667673870e-18     3.6295742780670641e-17     5.0696161659420108e-18     8.3121191256925030e-09     8.0768873263391783e-09    -9.4142549260756642e-10    -6.0059769841181945e-09    -1.4453720395610344e-09     3.5897591870030098e-09    -1.3288264739114853e-09    -2.6269667783477405e-17     1.1475428853797320e-01     7.4606674253881455e-02     5.8687997505631306e-02    -9.9130022859184805e-17     9.6209785248733443e-17     4.4232429031888413e-17    -5.4784581274134978e-17    -2.9154481445057506e-16     6.7973772154205176e-09     6.6045434863160681e-09    -7.7489322976591121e-10    -4.9156069018751055e-09    -1.1886948144350824e-09     2.9360092267992695e-09    -1.0872190443650134e-09     " transition="[ Reference -- EOMIP-CCSD state  1/A   ]"/>
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
    correlation                CCSD
    basis                      aug-cc-pVTZ
    purecart                   111           (5D)
    unrestricted               false
    cc_symmetry                false
    eom_ip_states              [1]
    cc_trans_prop              true
    ccman2                     true
    cc_do_dyson                true
    cc_t_conv                  7
    eom_davidson_convergence   6
    print_general_basis        true
    $end


    --------------------------------------------------------------
    </qchem_input>
    </root>
    EOF
  end

end
