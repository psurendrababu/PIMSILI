import os
from setuptools import setup, find_packages

ROOT_DIR = os.path.join(os.path.dirname(os.path.abspath(__file__)), "pimsili")
__version__ = '2.7.01'

with open("README.md", "r") as rf:
    long_description = rf.read()
installrequires = ['azure', 'pywin32',  'reportlab', ]

setup(
      name='PimsILI',
      version =__version__,
      description = 'Provides tools for running and managing Liquids HCA from Python',
      long_description = long_description,
      author = 'G2 Integrated Solutions.',
      author_email = 'support@g2-is.com',
      url = 'http://g2-is.com',
      license = 'license.txt',
      classifiers=[
          "Programming Language :: Python :: 3",
          "Operating System :: Microsoft :: Windows",
           ],
      project_urls={
          "Documentation": "https://g2-is.com/",
          "Code": "https://github.com/",
          "Issue tracker": "https://github.com/",
        },
      maintainer="G2 Integrated Solutions",
      maintainer_email="support@g2-is.com",
      packages = find_packages(exclude=["*.tests", "*.tests.*", "tests.*", "tests", "eol"]),
      # python_requires='>=3.6',
      package_dir = {'pimsili':'pimsili'},
      package_data = {'pimsili': ['esri\\toolboxes\\*', 'packages\\*']},
      #install_requires = installrequires,
      #install_requires = ['azure', 'pywin32',  'reportlab', ],
                          # 'evoleap_licensing',],
      )


